package unicore.rolemanage.mapper;

import org.apache.ibatis.annotations.Mapper;
import unicore.rolemanage.model.Role;
import java.util.List;

@Mapper
public interface RoleMapper {

    List<Role> findAll();

    Role findById(Long id);

    void insert(Role role);

    void update(Role role);

    void delete(Long id);

}