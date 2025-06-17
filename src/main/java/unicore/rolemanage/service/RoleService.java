package unicore.rolemanage.service;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import unicore.rolemanage.mapper.RoleMapper;
import unicore.rolemanage.model.Role;

import java.util.List;

@Service
@RequiredArgsConstructor
public class RoleService {

    private final RoleMapper roleMapper;

    // 전체 권한 목록 조회
    public List<Role> getAll() {
        return roleMapper.findAll();
    }

    // ID로 권한 조회
    public Role getById(Long id) {
        return roleMapper.findById(id);
    }

    // 권한 저장 (등록 또는 수정)
    public void save(Role role) {
        if (role.getId() == null) {
            roleMapper.insert(role);
        } else {
            roleMapper.update(role);
        }
    }

    // 권한 삭제
    public void delete(Long id) {
        roleMapper.delete(id);
    }
}