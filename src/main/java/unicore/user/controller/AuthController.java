package unicore.user.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;

@Controller
public class AuthController {

    @GetMapping("/login")
    public String loginForm() {
        return "user/login"; // → /WEB-INF/views/login.jsp
    }

    @PostMapping("/login")
    public String loginProcess(@RequestParam String username,
                               @RequestParam String password,
                               HttpSession session) {

        //TODO.DB로 연결해서 관리 필요
        if ("admin".equals(username) && "1234".equals(password)) {
            session.setAttribute("user", username); // 세션에 사용자 정보 저장
            return "redirect:/dashboard.do";
        } else {
            session.setAttribute("loginError", "아이디 또는 비밀번호가 잘못되었습니다.");
            return "redirect:/login";
        }
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate(); // 세션 종료
        return "redirect:/login";
    }


}
