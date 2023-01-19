package com.flodeus.integration;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/api/v1")
public class DateController {

    @GetMapping("/date")
    public Map getDate(){
        Map<String, String> response = new HashMap<>();
        response.put("now", new Date().toString());
        return response;
    }
}
