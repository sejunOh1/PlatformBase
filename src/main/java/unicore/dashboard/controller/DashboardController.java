package unicore.dashboard.controller;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Controller
public class DashboardController {

    private static final Logger logger = LogManager.getLogger(DashboardController.class);

    @GetMapping({"/", "/dashboard.do"})
    public String dashboard(HttpServletRequest request, HttpSession session) {
        logger.info("✅ MainController: /dashboard.do 요청 들어옴");

        Object user = session.getAttribute("user"); // 세션에서 로그인 사용자 확인
        if (user == null) {
            logger.info("🔒 로그인 세션 없음. /login 으로 리다이렉트");
            return "redirect:/login";
        }

        request.setAttribute("originalUri", "/dashboard.do");

        return "dashboard"; // JSP 경로: /WEB-INF/views/user/dashboard.jsp
    }


}
