package unicore.accesslog.mapper;

import org.apache.ibatis.annotations.Mapper;
import unicore.accesslog.model.AccessLog;

import java.util.List;

@Mapper
public interface AccessLogMapper {
    void insert(AccessLog log);
    List<AccessLog> findAll();
    
}
