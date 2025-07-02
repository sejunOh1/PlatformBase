package unicore.dashboard.controller;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import unicore.security.CustomUserDetails;

@Controller
public class DashboardController {

    private static final Logger logger = LogManager.getLogger(DashboardController.class);

    @PreAuthorize("hasRole('ADMIN')")
    @GetMapping({"/", "/dashboard"})
    public String dashboard(@AuthenticationPrincipal CustomUserDetails user, Model model) {
        logger.info("대시보드 접속 사용자: {}", user.getUserId());

        model.addAttribute("username", user.getUsername());
        model.addAttribute("deptName", user.getDeptName());
        model.addAttribute("role", user.getRole());

        return "user/dashboard";
    }

}
