package unicore.controller;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MainController {

    private static final Logger logger = LogManager.getLogger(MainController.class);

    @GetMapping({"/", "/main.do"})
    public String helloView() {
        System.out.println("✅ MainController: /main.do 요청 들어옴");
        return "home"; // home.jsp
    }


}
