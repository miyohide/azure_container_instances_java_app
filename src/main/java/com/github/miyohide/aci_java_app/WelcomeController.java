package com.github.miyohide.aci_java_app;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.net.InetAddress;
import java.net.NetworkInterface;
import java.net.SocketException;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;

@Controller
public class WelcomeController {
    @GetMapping("/")
    public String index(Model model) throws SocketException {
        List<String> addresses = new ArrayList<>();
        /* IPアドレスの取得処理。 InetAddress.getLocalHost().getHostAddress()
        * を実行した場合、127.0.0.1だけが返ってくることがあるので、それを防ぐために
        * ネットワークインターフェイスを取得し、それぞれにおいてIPアドレスを取得する
        * 実装としている。
        */
        Enumeration<NetworkInterface> n = NetworkInterface.getNetworkInterfaces();
        while (n.hasMoreElements()) {
            NetworkInterface e = n.nextElement();
            Enumeration<InetAddress> a = e.getInetAddresses();
            while (a.hasMoreElements()) {
                InetAddress addr = a.nextElement();
                addresses.add("Display Name = [" + e.getDisplayName() + "], Host Address = [" + addr.getHostAddress() + "]");
            }
        }
        model.addAttribute("addresses", addresses);
        return "index";
    }
}
