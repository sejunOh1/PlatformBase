package unicore.accesslog.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import unicore.accesslog.model.AccessLog;
import unicore.accesslog.service.AccessLogService;

import java.util.List;

@Controller
@RequiredArgsConstructor
public class AccessLogController {

    private final AccessLogService accessLogService;

    /** JSP 페이지 반환 (기본 뷰) */
    @GetMapping("/accesslog/list")
    public String listPage(Model model) {
        return "accesslog/list";
    }

    /** JSON 데이터 반환 (Grid용 API) */
    @GetMapping(value = "/accesslog/list.json")
    @ResponseBody
    public List<AccessLog> getAccessLogs() {
        return accessLogService.findAll();
    }

}
