package com.api.Controllers;

import com.api.Utils.Util;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping ("/pruebas")
public class PruebasController {

    @PostMapping (path = "/json")
    public boolean readJson() {
        String json = "{\"cdic\":\"24-09-2021\",\"pl\":[{\"attr\":[]}]}";
        System.out.printf("aca paso bn");
        Util.validKeyOfJsonLealtad(json);
        return true;
    }

}
