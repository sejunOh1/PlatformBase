package unicore.rolemanage.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import unicore.rolemanage.model.Role;
import unicore.rolemanage.service.RoleService;

import java.util.List;

@Controller
@RequestMapping("/rolemanage")
@RequiredArgsConstructor
public class RoleController {

    private final RoleService roleService;

    // 권한 목록 조회
    @GetMapping("/rolemanage-list")
    public String list(Model model) {
        List<Role> roles = roleService.getAll();
        model.addAttribute("roleList", roles);
        model.addAttribute("contentPage", "rolemanage/rolemanage-list.jsp");
        //return "rolemanage/rolemanage-list";  // -> /WEB-INF/views/role/list.jsp
        return "layout";
    }

    // 권한 등록/수정 폼
    @GetMapping("/rolemanage-form")
    public String form(@RequestParam(required = false) Long id, Model model) {
        Role role = (id != null) ? roleService.getById(id) : new Role();
        model.addAttribute("role", role);
        return "rolemanage/rolemanage-form";  // -> /WEB-INF/views/role/form.jsp
    }

    // 권한 저장
    @PostMapping("/save")
    public String save(@ModelAttribute Role role) {
        roleService.save(role);
        return "redirect:/role/list";
    }

    // 권한 삭제
    @GetMapping("/delete")
    public String delete(@RequestParam Long id) {
        roleService.delete(id);
        return "redirect:/role/list";
    }

}
