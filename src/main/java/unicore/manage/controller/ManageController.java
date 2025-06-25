package unicore.manage.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import unicore.manage.model.ManageItem;
import unicore.manage.service.ManageService;

import java.util.List;

@Controller
@RequiredArgsConstructor
@RequestMapping("/manage")
public class ManageController {

    private final ManageService manageService;

    @GetMapping("/list")
    public String list(Model model) {

        return "manage/list";
    }

    @PostMapping("/save")
    public String save(@ModelAttribute ManageItem item) {
        manageService.save(item);
        return "redirect:/manage/list";
    }

    @GetMapping("/delete")
    public String delete(@RequestParam Long id) {
        manageService.delete(id);
        return "redirect:/manage/list";
    }

}
