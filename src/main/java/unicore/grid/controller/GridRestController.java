package unicore.grid.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/grid")
public class GridRestController {

    @PostMapping("/users")
    public List<Map<String, Object>> getUsers(@RequestBody(required = false) Map<String, Object> params) {
        Integer minAge = params != null ? (Integer) params.get("minAge") : null;

        List<Map<String, Object>> result = new ArrayList<>();
       
        // 서버에서 데이터 넘겼다고 가정
        for (int i = 1; i <= 500000; i++) {
            int age = 20 + (i % 15);
            if (minAge != null && age < minAge) continue;

            Map<String, Object> row = new HashMap<>();
            row.put("id", i);
            row.put("name", "사용자" + i);
            row.put("age", age);
            row.put("email", "user" + i + "@example.com");
            result.add(row);
        }

        return result;
    }
}
