package com.api.Controllers;

import java.util.*;
import com.api.Entity.DateMonitoring;
import com.api.ModelVO.UsuarioVO;
import com.api.Services.IUsuarioService;
import com.api.Services.MonitoringService;
import com.api.Utils.Util;
import com.fasterxml.jackson.databind.ObjectMapper;
import javax.validation.Valid;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.scheduling.annotation.Async;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.util.StringUtils;

@CrossOrigin (origins = "http://localhost:4200", maxAge = 3600)
@RestController
@RequestMapping ("/api/users")
public class UsuarioController {

    @Value ("#{'${path.api.users}'}")
    private String PATH_API_USERS;

    private static final Logger logger = LoggerFactory.getLogger(UsuarioController.class);
    private static final ObjectMapper objMap = new ObjectMapper();
    private static final RestTemplate restTemplate = new RestTemplate();

    @Autowired
    IUsuarioService service;
    @Autowired
    MonitoringService monitoringService;

    @Value ("${key.not.change}")
    String notkeys;

    @PostMapping
    @Async
    public void compareJson() {

        String upd = "{\"ivaA\": \"0\",\"ivaT\": \"1\",\"iac\": \"1\",\"iacA\": \"1\",\"iacT\": \"1\",\"cv\": \"0\",\"prop\":\"0\",\"ag\":\"0\"}";
        String old = "{\"ivaA\": \"1\",\"ivaT\": \"0\",\"iac\": \"0\",\"iacA\": \"0\",\"iacT\": \"0\",\"cv\": \"1\",\"prop\":\"1\",\"ag\":\"1\"}";

        JSONObject jsUpd = new JSONObject(upd);
        logger.info("upd --> " + jsUpd);

        JSONObject jsOld = new JSONObject(old);
        logger.info("old --> " + jsOld);

        JSONObject jsonNot = new JSONObject(notkeys);
        logger.info("not --> " + jsonNot);


        for (String key : JSONObject.getNames(jsUpd)) {
            if (!jsonNot.has(key)) {
                jsOld.put(key, jsUpd.get(key));
            }
        }

        logger.info("finish --> " + jsOld);
    }

    // Lista de usuarios
    @GetMapping (path = "/list/{option}", produces = MediaType.APPLICATION_JSON_VALUE)
    private ResponseEntity<Object> listUsers(@PathVariable String option) {
        List<UsuarioVO> listusers = service.listUsers(option);
        return ResponseEntity.status(listusers != null ? HttpStatus.OK : HttpStatus.NOT_FOUND).body(listusers != null ? listusers : Util.messageJson("Sin información"));
    }

    @PostMapping (path = "/calculo")
    public void calculo() {
        try {


            /*
            CREATE TABLE DATE_MONITORING (
                    ID INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
                    DATE_MONITORING DATE,
                    TIME_MONITORING TIME,
                    TIME_ON TIME,
                    TIME_OFF TIME,
                    DAYS_WORKS INT
);
             */

            DateMonitoring dtm = monitoringService.searchMonitoring();

            if (dtm != null) {
                logger.info("Encontre información");
            }

            int diasopera = 6;

            Date actual = new Date();
            Calendar calendar = Calendar.getInstance();
            calendar.setTime(actual);
            logger.info("Dias opera: " + diasopera);
            logger.info("Fecha actual: " + calendar.getTime());
            logger.info("Numero dia request: " + calendar.getTime().getDay());


            calendar.add(Calendar.DAY_OF_YEAR, 1);
            /*calendar.add(Calendar.HOUR, 2);
            calendar.add(Calendar.SECOND, 15);*/

            int diaMonitoring = calendar.getTime().getDay() == 0 ? 7 : calendar.getTime().getDay();
            logger.info("Numero dia proximo monitoreo: " + diaMonitoring);

            if (diaMonitoring >= diasopera) {
                logger.info("El dia no esta en el rango que opera");
                int faltan = 7 - diasopera;
                logger.info("faltan: " + faltan);
                calendar.add(Calendar.DAY_OF_YEAR, faltan);
            }
            List<DateMonitoring> list = monitoringService.searchMonitoringdate(calendar.getTime());

            if (list != null) {
                logger.info("Ya hay monitoreo para este dia");
            }


            logger.info("Response proximo monitoreo: " + calendar.getTime());
        } catch (Exception e) {
            logger.error("Error al calcular: ", e);
        }
    }

    // Consulta usuario por id
    @GetMapping (path = "/search/{id:[\\d]+}", produces = MediaType.APPLICATION_JSON_VALUE)
    private ResponseEntity<Object> searchUser(@PathVariable long id) {
        UsuarioVO usvo = service.searchUser(id);
        return ResponseEntity.status(usvo != null ? HttpStatus.OK : HttpStatus.NOT_FOUND).body(usvo != null ? usvo : Util.messageJson("Este usuario no existe"));
    }

    // Consulta usuario por correo
    @GetMapping (path = "/search", produces = MediaType.APPLICATION_JSON_VALUE)
    private ResponseEntity<Object> searchUser(@RequestParam String email) {
        UsuarioVO usvo = service.searchUser(email);
        return ResponseEntity.status(usvo != null ? HttpStatus.OK : HttpStatus.NOT_FOUND).body(usvo != null ? usvo : Util.messageJson("Información no encontrada"));
    }

    // Registrar usuario
    @PostMapping (path = "/add", produces = MediaType.APPLICATION_JSON_VALUE, consumes = MediaType.APPLICATION_JSON_VALUE)
    private ResponseEntity<String> createUser(@Valid @RequestBody UsuarioVO usvo, BindingResult result) {
        if (result.hasErrors() || usvo.getUsclave() == null) {
            if (usvo.getUsclave() == null) {
                result.rejectValue("usclave", "400", "La clave es obligatoria");
            }
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(Util.errorsJson(result));
        }
        String add = service.createUser(usvo);
        return ResponseEntity.status(add.equals("Agregado") ? HttpStatus.CREATED : HttpStatus.BAD_REQUEST).body(Util.messageJson(add));
    }

    // Actualizar usuario
    @PutMapping (path = "/update/information/{type}", produces = MediaType.APPLICATION_JSON_VALUE, consumes = MediaType.APPLICATION_JSON_VALUE)
    private ResponseEntity<String> updateInformation(@Valid @RequestBody UsuarioVO usvo, BindingResult result, @PathVariable String type) {
        if (result.hasErrors()) {
            return ResponseEntity.status(HttpStatus.OK).body(Util.errorsJson(result));
        }
        String update = service.updateInformation(usvo, type);
        return ResponseEntity.status(update.equals("Actualizado") ? HttpStatus.OK : HttpStatus.BAD_REQUEST).body(Util.messageJson(update));
    }

    // Actualiza clave
    @PutMapping ("/update/password")
    private ResponseEntity<Boolean> updatePassword(@RequestParam long id, @RequestParam String passwordOld, @RequestParam String passwordNew) {
        boolean updatepassword = service.updatePassword(id, passwordOld, passwordNew);
        return ResponseEntity.status(updatepassword ? HttpStatus.OK : HttpStatus.BAD_REQUEST).body(updatepassword);
    }

    // Actualiza el estado del usuario
    @PutMapping ("/update/status/{status}")
    public ResponseEntity<Object> updateStatus(@PathVariable int status, @RequestParam long id) {
        UsuarioVO usvo = service.updateStatus(status, id);
        return ResponseEntity.status(HttpStatus.OK).body(usvo != null ? usvo : Util.messageJson("No actualizado"));
    }

    @DeleteMapping ("/delete")
    private ResponseEntity<Boolean> deleteUser(@RequestParam long id) {
        boolean delete = service.deleteUser(id);
        return ResponseEntity.status(delete ? HttpStatus.OK : HttpStatus.BAD_REQUEST).body(delete);
    }

    // ============ METODOS QUE CONSUMEN API PARA HACER PRUEBAS DE CONSUMO CON JAVA
    @GetMapping ("/consulta/{id}")
    private void consultarUsuario(@PathVariable long id) {
        try {

            ResponseEntity<String> response = restTemplate.getForEntity(PATH_API_USERS + "/search/" + id, String.class);

            if (response.getStatusCode().equals(HttpStatus.OK)) {
                // Mapea objeto JSON de UsuarioVO
                UsuarioVO usvo = objMap.readValue(response.getBody(), UsuarioVO.class);
                logger.info("Nombres: " + usvo.getUsnombres());
                logger.info("Area: " + usvo.getArea().getArNombre());
                logger.info("Rol: " + usvo.getRol().getRolNombre());

            } else if (response.getStatusCode().equals(HttpStatus.NOT_FOUND)) {
                logger.info("Sin informacion");
            }

        } catch (Exception e) {
            logger.error("ERROR AL CONSUMIR API:  " + e);
        }
    }

    // ========================================= PRUEBAS

    // ============ UPLOAD FILE
    @PostMapping (path = "/file", produces = MediaType.APPLICATION_JSON_VALUE, consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public ResponseEntity<String> uploadFile(@RequestParam ("file") List<MultipartFile> file, @RequestParam ("os") List<MultipartFile> os, @RequestParam ("init") List<MultipartFile> init) throws Exception {

        logger.info("Hay file: ");
        // ==== FORMA UNO
        List<MultipartFile> fileOS = new ArrayList<>();
        List<MultipartFile> fileJSON = new ArrayList<>();
        List<MultipartFile> files = new ArrayList<>();

        for (MultipartFile f : file) {
            String extension = StringUtils.getFilenameExtension(f.getOriginalFilename());
            logger.info(extension);
            logger.info(f.getContentType());
            if (f.getContentType().equals("application/octet-stream")) {
                logger.info("Sistema operativo");
                fileOS.add(f);
            } else if (f.getContentType().equals("application/json")) {
                logger.info("Un json");
                fileJSON.add(f);
            } else {
                logger.info("Archivos.");
                files.add(f);
            }
        }

        // ====

        if (os.size() > 0) {
            byte[] zipBytesOS = Util.comprimirMultiFile(os);
            String b64OS = Base64.getEncoder().encodeToString(zipBytesOS);
            //logger.info("B64OS : " + b64OS);
        }
        if (file.size() > 0) {
            byte[] zipBytesJSON = Util.comprimirMultiFile(file);
            String b64JSON = Base64.getEncoder().encodeToString(zipBytesJSON);
            //logger.info("b64JSON : " + b64JSON);
        }
        if (init.size() > 0) {
            byte[] zipBytesFiles = Util.comprimirMultiFile(init);
            String b64FILES = Base64.getEncoder().encodeToString(zipBytesFiles);
            //logger.info("b64FILES : " + b64FILES);
        }

        logger.info("Termino por completo");

        return ResponseEntity.status(HttpStatus.OK).body(Util.messageJson("OK"));
    }


    // ==== Consume esta misma api el metodo de listar usuarios
    @GetMapping ("/lista")
    private void listarUsuarios() {
        try {
            ResponseEntity<String> listusers = restTemplate.exchange(PATH_API_USERS + "/list/all", HttpMethod.GET, Util.getHttpEntity(), String.class);

            logger.info(listusers.getBody());
            if (listusers.getStatusCode().equals(HttpStatus.OK)) {

                UsuarioVO[] usvoArray = objMap.readValue(listusers.getBody(), UsuarioVO[].class);

                for (UsuarioVO us : usvoArray) {
                    UsuarioVO usvo = new UsuarioVO();
                    usvo.setUsnombres(us.getUsnombres());
                    usvo.setArea(us.getArea());
                    usvo.setRol(us.getRol());
                    logger.info("Nombres: " + usvo.getUsnombres());
                    logger.info("Area: " + usvo.getArea().getArNombre());
                    logger.info("Rol: " + usvo.getRol().getRolNombre());
                }

            } else if (listusers.getStatusCode().equals(HttpStatus.NOT_FOUND)) {
                logger.warn("No se obtuvo estado 500 con lista:");
            }

        } catch (Exception e) {
            logger.error("Error al obtener lista: " + e);
        }
    }

    // ==== Consume esta misma api el metodo de add usuario
    @PostMapping ("/agregar")
    public void agregarUsuario() {

        try {
            // === Envia post con objeto class

            /* UsuarioVO usvo = new UsuarioVO();
            usvo.setUsnombres("Alejandro");
            usvo.setUsapellidos("Garcia");
            usvo.setUscorreo("alejo@gmail.com");
            usvo.setUsclave("miclave");
            usvo.setUsestado(1);
            usvo.setRolid(2);
            usvo.setArid(3);

            ResponseEntity<String> requestAdd = restTemplate.exchange(PATH_API_USERS + "/add", HttpMethod.POST,Util.getHttpEntity(usvo), String.class);
            logger.info("requestAdd: " + requestAdd.getBody());*/
            // === Envia por post con objeto json

            JSONObject json = new JSONObject();
            json.put("nombres", "Spring").put("apellidos", "boot");
            json.put("telefono", "88888").put("correo", "spring@gmail.com").put("clave", "passboot");
            json.put("estado", 1).put("Idrol", 3).put("IdArea", 1);

            ResponseEntity<String> request = restTemplate.postForEntity(PATH_API_USERS + "/add", Util.getHttpEntity(json), String.class);
            logger.info("request: " + request.getBody());

            if (request.getStatusCode().equals(HttpStatus.CREATED)) {
                logger.info("Usuario agregado");
            }

        } catch (Exception e) {
            logger.error("Error al agregar el usuario desde el metodo agregarUsuario: " + e);
        }
    }
}
