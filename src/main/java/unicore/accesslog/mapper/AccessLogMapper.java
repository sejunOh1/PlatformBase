package unicore.accesslog.mapper;

import org.apache.ibatis.annotations.Mapper;
import unicore.accesslog.model.AccessLog;

@Mapper
public interface AccessLogMapper {
    void insert(AccessLog log);
}
