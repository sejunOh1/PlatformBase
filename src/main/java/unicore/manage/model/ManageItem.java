package unicore.manage.model;

import lombok.Data;

@Data
public class ManageItem {
    private Long id;
    private String title;
    private String content;
    private String createdBy;
    private String createdAt;
}
