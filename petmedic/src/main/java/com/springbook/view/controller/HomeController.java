package com.springbook.view.controller;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


@Controller
public class HomeController {

    @RequestMapping(value = "/.well-known/pki.validation/993939D9730E7E0DAC4E4FFA49797B3F.txt")
    public void https(HttpServletResponse response) throws IOException {
        String filePath = "C:\\vet\\petmedic\\src\\main\\webapp\\.well-known\\pki-validation\\993939D9730E7E0DAC4E4FFA49797B3F.txt";
        
        response.setContentType("text/plain");
        
        FileInputStream fileInputStream = new FileInputStream(filePath);
        
        OutputStream outputStream = response.getOutputStream();
        byte[] buffer = new byte[4096];
        int bytesRead;
        while ((bytesRead = fileInputStream.read(buffer)) != -1) {
            outputStream.write(buffer, 0, bytesRead);
        }
        
        fileInputStream.close();
        outputStream.close();
    }
}

