package com.api.Utils;

import com.api.ModelVO.UsuarioVO;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.*;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;
import java.io.ByteArrayOutputStream;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

public class Util {

    private static JSONObject json = null;
    private static final Logger logger = LoggerFactory.getLogger(Util.class);

    // ===== Método para enviar los errores de atributos en un JSON
    public static String errorsJson(BindingResult result) {
        json = new JSONObject();
        for (FieldError error : result.getFieldErrors()) {
            json.put(error.getField(), error.getDefaultMessage());
        }
        return json.toString();
    }

    // ===== Método para enviar mensajes en json a response
    public static String messageJson(String value) {
        json = new JSONObject();
        return json.put("message", value).toString();
    }

    // ============ Método para obtener los bytes de un archivo a zip al compress un file
    public static byte[] getBytesFileZip(MultipartFile file) {
        byte[] zipBytes = null;
        try {
            ByteArrayOutputStream bitArrayOut = new ByteArrayOutputStream();
            ZipOutputStream zos = new ZipOutputStream(bitArrayOut);
            zos.setMethod(ZipOutputStream.DEFLATED);
            String fileName = file.getOriginalFilename();
            zos.putNextEntry(new ZipEntry(fileName));

            byte[] bytes = file.getBytes();
            zos.write(bytes, 0, bytes.length);
            zos.closeEntry();
            zos.finish();
            zos.close();
            zipBytes = bitArrayOut.toByteArray();
        } catch (Exception e) {
            logger.error("Error al obtener comprimir y obtener bytes de file en Util getBytesFileZip : ");
        }
        return zipBytes;
    }


    // ======================== Metodos HTTP enviar json u object en Entity

    private static HttpHeaders getHttpHeaders() {
        HttpHeaders headers = new HttpHeaders();
        headers.set("Content-Type", MediaType.APPLICATION_JSON_VALUE);
        headers.set("Accept", MediaType.APPLICATION_JSON_VALUE);
        headers.set("Authorization", "Bearer token");
        return headers;
    }

    public static HttpEntity getHttpEntity() {
        return new HttpEntity(getHttpHeaders());
    }

    // == HttpEntity para enviar objeto en formato json
    public static HttpEntity getHttpEntity(UsuarioVO usvo) {
        JSONObject json = new JSONObject(usvo);
        return new HttpEntity(json.toString(), getHttpHeaders());
    }

    // == HttpEntity para enviar objeto json
    public static HttpEntity getHttpEntity(JSONObject json) {
        return new HttpEntity(json.toString(), getHttpHeaders());
    }

    // ================= Metodos Http para enviar body en entity para autenticacion y obtener token

    private static void getToken() {

        String PATH_SSO = "PATH_SSO";
        RestTemplate template = new RestTemplate();

        try {

            HttpEntity<?> entity = new HttpEntity<Object>(getBodySSO(), getHttpHeadersUrlEncoded());
            ResponseEntity<String> response = template.exchange(PATH_SSO, HttpMethod.POST, entity, String.class);

            JSONObject jsonResponse = new JSONObject(response.getBody());
            String TOKEN = jsonResponse.get("access_token").toString();

        } catch (Exception e) {
            logger.error("Error al obtener el token: ", e);
        }
    }

    private static HttpHeaders getHttpHeadersUrlEncoded() {
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);
        headers.add("Accept", "application/json");
        headers.add("Authorization", "Basic TOKEN");
        return headers;
    }

    private static MultiValueMap<String, String> getBodySSO() {
        MultiValueMap<String, String> body = new LinkedMultiValueMap<>();
        body.add("username", "user");
        body.add("password", "contraseña");
        body.add("grant_type", "grantype");
        body.add("client_id", "id_cliente");
        body.add("refresh_token", "Bearer TOKEN");
        return body;
    }

}
