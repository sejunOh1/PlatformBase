package unicore.chart.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("chart")
public class ChartController {


    @GetMapping("/chart")
    public String list(Model model) {
        //List<ManageItem> items = manageService.getList();
        //model.addAttribute("items", items);
        model.addAttribute("contentPage", "/chart/chart.jsp");
        return "chart/chart";
    }

}
