package com.api.Controllers;

import com.api.Utils.Util;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.nio.charset.StandardCharsets;
import java.util.Base64;

@RestController
@RequestMapping ("/api")
public class PruebasController {

    @PostMapping (path = "/file")
    public boolean readJson() {
        try {

            // Download in zip
            File filezip = new File("C:\\Users\\jonny\\Downloads\\pruebas" + ".zip");
            String texto = "texto en txt dentro de un zip";
            byte[] bytesFileZip = Util.comprimirFile(texto.getBytes(StandardCharsets.UTF_8), "pruebas");
            OutputStream os = new FileOutputStream(filezip);
            os.write(bytesFileZip);
            os.close();
            // Download in txt
            File filetxt = new File("C:\\Users\\jonny\\Downloads\\pruebas" + ".txt");
            texto = "texto dentro de solo txt";
            byte[] bytesTxt = texto.getBytes(StandardCharsets.UTF_8);
            os = new FileOutputStream(filetxt);
            os.write(bytesTxt);
            os.close();

            System.out.println(bytesFileZip);
            String sBase64 = Base64.getEncoder().encodeToString(bytesFileZip);
            System.out.println("B64: " + sBase64);

        } catch (Exception e) {

        }
        System.out.printf("aca paso bn");
        return true;
    }

}
