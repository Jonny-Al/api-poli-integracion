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
import java.io.ByteArrayOutputStream;
import java.util.Iterator;
import java.util.Map;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

@Component
public class Util {

    // PARA QUE LOS @VALUE TOMEN LOS VALORES DEL PROPERTIES EN ESTA CLASE DEBE ESTAR EL @Component
    // y en la clase donde se va llamar el metodo que requiere ejecutar donde se usan los @value debe ser con @Autowired ejemplo :
    // @Autowired Util util;
    @Value ("${sso.usuario}")
    private String sso_usuario;

    @Value ("${sso.clave}")
    private String sso_clave;

    @Value ("${sso.idcliente}")
    private String sso_idcliente;

    @Value ("${sso.refresh.token}")
    private String sso_refresh_token;

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

    public static String validKeyOfJsonLealtad(String jsonVariables) {
        JSONObject json = new JSONObject(jsonVariables);
        ObjectMapper objectMapper = new ObjectMapper();
        try {
            if (json.has("pl")) {
                if (!json.get("pl").toString().equalsIgnoreCase("null")) {

                    json = new JSONObject(jsonVariables);
                    int eliminados = 0;

                    logger.info("Tiene parametros de lealtad se procede a revisar si algun programa se debe eliminar");
                    JSONArray jsonArray = json.getJSONArray("pl");
                    int totalleal = jsonArray.length();

                    for (int i = 0; i < jsonArray.length(); i++) {
                        JSONObject jsonPl = jsonArray.getJSONObject(i);
                        if (jsonPl.has("k")) {
                            if (jsonPl.has("dlt")) {
                                if (jsonPl.get("dlt").equals(true)) {
                                    jsonArray.remove(i);
                                    eliminados++;
                                    --i;
                                }
                            }
                        } else {
                            json.remove("pl");
                            break;
                        }
                    }

                    if (eliminados == totalleal) {
                        if (json.has("pl")) {
                            json.remove("pl");
                        }
                    }
                } else {
                    json.remove("pl");
                }
                Object objJson = objectMapper.readValue(json.toString(), Object.class);
                jsonVariables = objectMapper.writeValueAsString(objJson);
                logger.info("Parametros definidos: " + jsonVariables);

            }
        } catch (Exception e) {
            logger.error("Error con llaves de lealtad en las utilidades validKeyOfJsonLealtad : ", e);
        }
        return jsonVariables;
    }

    // ================= Metodos Http para enviar body en entity para autenticacion y obtener token con XXX FORM URL ENCODED

    private void getToken() {

        String PATH_SSO = "PATH_SSO";
        RestTemplate template = new RestTemplate();

        try {

            ResponseEntity<String> response = template.exchange(PATH_SSO, HttpMethod.POST, getHttpEntitySSO(), String.class);
            JSONObject jsonResponse = new JSONObject(response.getBody());
            String TOKEN = jsonResponse.get("access_token").toString();

        } catch (Exception e) {
            logger.error("Error al obtener el token: ", e);
        }
    }

    private HttpEntity getHttpEntitySSO() {
        return new HttpEntity<Object>(getBodySSO(), getHttpHeadersUrlEncoded());
    }


    private HttpHeaders getHttpHeadersUrlEncoded() {
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);
        headers.add("Accept", "application/json");
        headers.add("Authorization", "Basic TOKEN");
        return headers;
    }


    public MultiValueMap<String, String> getBodySSO() {

        System.out.println(sso_usuario);
        System.out.println(sso_clave);
        System.out.println(sso_idcliente);
        System.out.println(sso_refresh_token);

        MultiValueMap<String, String> body = new LinkedMultiValueMap<>();
        body.add("username", sso_usuario);
        body.add("password", sso_clave);
        body.add("grant_type", "grantype");
        body.add("client_id", sso_idcliente);
        body.add("refresh_token", "Bearer " + sso_refresh_token);
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

}
