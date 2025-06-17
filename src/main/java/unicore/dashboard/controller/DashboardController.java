package unicore.dashboard.controller;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class DashboardController {

    private static final Logger logger = LogManager.getLogger(DashboardController.class);

    @GetMapping({"/", "/dashboard.do"})
    public String dashboard(Authentication auth, Model model) {
            logger.info("대시보드 접속 사용자: {}", auth.getName());

            model.addAttribute("username", auth.getName());
            model.addAttribute("contentPage", "user/dashboard.jsp"); // 본문 JSP 경로를 모델에 포함
            return "layout";
    }

}
