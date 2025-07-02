package unicore.accesslog.service;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import unicore.accesslog.mapper.AccessLogMapper;
import unicore.accesslog.model.AccessLog;

import java.util.List;

@Service
@RequiredArgsConstructor
@Transactional
public class AccessLogService {

    private final AccessLogMapper accessLogMapper;

    public void save(AccessLog log) {
        accessLogMapper.insert(log);
    }

    public List<AccessLog> findAll() {
        return accessLogMapper.findAll();
    }

}
