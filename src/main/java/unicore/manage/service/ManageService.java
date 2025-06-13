package unicore.manage.service;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import unicore.manage.mapper.ManageMapper;
import unicore.manage.model.ManageItem;

import java.util.List;

@Service
@RequiredArgsConstructor
public class ManageService {

    private final ManageMapper manageMapper;

    public List<ManageItem> getList() {
        return manageMapper.selectAll();
    }

    public ManageItem getItem(Long id) {
        return manageMapper.selectById(id);
    }

    public void save(ManageItem item) {
        if (item.getId() == null) {
            manageMapper.insert(item);
        } else {
            manageMapper.update(item);
        }
    }

    public void delete(Long id) {
        manageMapper.delete(id);
    }

}
