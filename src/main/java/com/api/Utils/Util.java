package com.api.Utils;

import com.api.ModelVO.UsuarioVO;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.json.JSONArray;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.stereotype.Component;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.util.*;
import java.util.zip.InflaterInputStream;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

@Component
public class Util {

    @Value ("${sso.path}")
    private String PATH_SSO;
    @Value ("${sso.basic.token}")
    private String BASIC_TOKEN;
    @Value ("${sso.username}")
    private String SSO_USERNAME;
    @Value ("${sso.password}")
    private String SSO_PASSWORD;
    @Value ("${sso.granttype}")
    private String SSO_GRANTTYPE;
    @Value ("${sso.clientid}")
    private String SSO_CLIENTID;

    private static JSONObject json = null;
    private static final Logger logger = LoggerFactory.getLogger(Util.class);
    private static RestTemplate rest = new RestTemplate();
    private static String TOKEN = null;

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

    // ============

    public boolean setCreateInApi() {

        logger.info("--- Inicio consumo api changes ---");
        boolean update = false;
        getTokenSSO();

        try {

            JSONObject json = new JSONObject();

            json.put("nombre", "alejandro");
            json.put("apellido", "garcia");
            json.put("status", 1);
            json.put("telefono", "215364545");

            ResponseEntity<String> response = rest.exchange("http://localhost:8080/api/create", HttpMethod.POST, getHttpEntity(json), String.class);
            logger.info("Response api create: " + response.getStatusCode());

            if (response.getStatusCode() == HttpStatus.OK) {
                logger.info("Se guardaron los cambios");
                update = true;
            } else {
                logger.info("No se registro los cambios");
            }
        } catch (Exception e) {
            logger.error("Error al enviar json a api : ", e);
        }
        return update;
    }


    public static HttpEntity getHttpEntity(JSONObject json) {
        return new HttpEntity(json.toString(), getHttpheadersJson());
    }

    public static HttpEntity getHttpEntity() {
        return new HttpEntity(getHttpheadersJson());
    }

    private static HttpHeaders getHttpheadersJson() {
        HttpHeaders headers = new HttpHeaders();
        headers.set("Content-Type", MediaType.APPLICATION_JSON_VALUE);
        headers.set("Accept", MediaType.APPLICATION_JSON_VALUE);
        headers.set("Authorization", "Bearer " + TOKEN);
        return headers;
    }

    // ===== METODOS PARA OBTENER TOKEN DEL SSO
    private void getTokenSSO() {
        try {
            ResponseEntity<String> response = rest.exchange(PATH_SSO, HttpMethod.POST, getHttpEntitySSO(), String.class);
            JSONObject jsonResponse = new JSONObject(response.getBody());
            TOKEN = jsonResponse.get("access_token").toString();
        } catch (Exception e) {
            logger.error("Error al obtener el token: ", e);
        }
    }



    private static HttpHeaders getHttpHeaders() {
        HttpHeaders headers = new HttpHeaders();
        headers.set("Content-Type", MediaType.APPLICATION_JSON_VALUE);
        headers.set("Accept", MediaType.APPLICATION_JSON_VALUE);
        headers.set("Authorization", "Bearer token");
        return headers;
    }

    private HttpEntity getHttpEntitySSO() {
        return new HttpEntity(getBodySSO(), getHttpHeadersUrlEncoded());
    }

    private HttpHeaders getHttpHeadersUrlEncoded() {
        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Type", "application/x-www-form-urlencoded");
        headers.add("Accept", "application/json");
        headers.add("Authorization", "Basic " + BASIC_TOKEN);
        return headers;
    }

    private MultiValueMap<String, String> getBodySSO() {
        MultiValueMap<String, String> body = new LinkedMultiValueMap<>();
        body.add("username", SSO_USERNAME);
        body.add("password", SSO_PASSWORD);
        body.add("grant_type", SSO_GRANTTYPE);
        body.add("client_id", SSO_CLIENTID);
        return body;
    }

    // ================ OBTENER LA KEY SIN SABER NOMBRE DE UN JSON

    private static void getkeyJson(String cadena) {

        try {

            JSONObject jsonObject = new JSONObject(cadena);
            Iterator<String> iteratorKey = jsonObject.keys();

            String key = iteratorKey.next();
            String value = jsonObject.get(key).toString();

            if (jsonObject.has("key")) { // Valida si una key existe en el json
                logger.info("Esta llave en el json si existe");
            }

            ObjectMapper mapper = new ObjectMapper();
            Map<String, String> map = mapper.readValue(value, Map.class);

            logger.info(map.get("mi-key-in-json-value"));

        } catch (Exception e) {
            logger.error("Error al obtener la llave del json: ", e);
        }

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

    public static byte[] comprimirMultiFile(List<MultipartFile> filesDownload) {
        byte[] zipBytes = null;

        try {
            ByteArrayOutputStream bitArrayOut = new ByteArrayOutputStream();
            ZipOutputStream zos = new ZipOutputStream(bitArrayOut);
            zos.setMethod(ZipOutputStream.DEFLATED);
            List<MultipartFile> files = filesDownload;
            // List<String> fileNames = new ArrayList<String>();
            if (null != files && files.size() > 0) {
                for (MultipartFile multipartFile : files) {
                    String fileName = multipartFile.getOriginalFilename();
                    zos.putNextEntry(new ZipEntry(fileName));

                    byte[] bytes = multipartFile.getBytes();
                    zos.write(bytes, 0, bytes.length);
                    zos.closeEntry();
                }
            }
            zos.finish();
            zos.close();
            zipBytes = bitArrayOut.toByteArray();
            //
        } catch (Exception e) {
            logger.error("ERROR AL COMPRIMIR EL FILE: ", e);
        }

        return zipBytes;
    }

    public static byte[] comprimirFile(byte[] data, String aliasData) {
        byte[] zipBytes = null;

        try {
            ByteArrayOutputStream bitArrayOut = new ByteArrayOutputStream();
            ZipOutputStream zos = new ZipOutputStream(bitArrayOut);
            zos.setMethod(ZipOutputStream.DEFLATED);
            zos.putNextEntry(new ZipEntry(aliasData + ".txt"));

            zos.write(data, 0, data.length);
            zos.closeEntry();

            zos.finish();
            zos.close();
            zipBytes = bitArrayOut.toByteArray();
        } catch (Exception e) {
            logger.error("ERROR AL COMPRIMIR EL FILE: " + e);
        }

        return zipBytes;
    }

    public static String inflate(String base64) {
        try {
            logger.info("base64<-: " + base64);
            byte[] decodedBytes = Base64.getDecoder().decode(base64);

            ByteArrayInputStream bais = new ByteArrayInputStream(decodedBytes);
            InflaterInputStream iis = new InflaterInputStream(bais);

            String outputString = "";
            byte[] buf = new byte[5];
            int rlen = -1;
            while ((rlen = iis.read(buf)) != -1) {
                outputString += new String(Arrays.copyOf(buf, rlen));
            }

            // now result will contain "Hello World!"
            System.out.println("Decompress result: " + outputString);
            logger.info("outputString<-: " + outputString);

            return outputString;
        } catch (Exception ex) {
            logger.error("error to inflate CUtilidades dowload", ex);
        }
        return null;
    }



}
