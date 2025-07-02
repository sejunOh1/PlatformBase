package unicore.grid.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("grid")
public class GridController {


    @GetMapping("/grid")
    public String list(Model model) {
        //List<ManageItem> items = manageService.getList();
        //model.addAttribute("items", items);
        model.addAttribute("contentPage", "/grid/grid.jsp");
        return "grid/grid";
    }
    
}
