package unicore.rolemanage.model;

import lombok.Data;

@Data
public class Role {
    private Long id;
    private String roleName;
    private String description;
}