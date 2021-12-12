package com.github.miyohide.aci_java_app;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.net.Inet4Address;
import java.net.UnknownHostException;

@Controller
public class WelcomeController {
    @GetMapping("/")
    public String index(Model model) throws UnknownHostException {
        model.addAttribute("server_ip_address", Inet4Address.getLocalHost().getHostAddress());
        return "index";
    }
}
