package unicore.manage.mapper;

import org.apache.ibatis.annotations.Mapper;
import unicore.manage.model.ManageItem;

import java.util.List;

@Mapper
public interface ManageMapper {
    List<ManageItem> selectAll();
    ManageItem selectById(Long id);
    int insert(ManageItem item);
    int update(ManageItem item);
    int delete(Long id);
}
