package unicore.user.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class AuthController {

    @GetMapping("/login")
    public String loginForm() {
        return "user/login"; // 로그인 페이지 JSP
    }

}
