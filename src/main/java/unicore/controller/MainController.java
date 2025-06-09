package unicore.controller;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import javax.servlet.http.HttpSession;

@Controller
public class MainController {

    private static final Logger logger = LogManager.getLogger(MainController.class);

    @GetMapping({"/", "/main.do"})
    public String home(HttpSession session) {
        logger.info("✅ MainController: /main.do 요청 들어옴");

        Object user = session.getAttribute("user"); // 세션에서 로그인 사용자 확인
        if (user == null) {
            logger.info("🔒 로그인 세션 없음. /login 으로 리다이렉트");
            return "redirect:/login";
        }

        return "home"; // → /WEB-INF/views/home.jsp
    }


}
