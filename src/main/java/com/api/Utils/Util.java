package com.api.Utils;

import com.api.ModelVO.UsuarioVO;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
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


    // ======================== Metodos HTTP
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
}
