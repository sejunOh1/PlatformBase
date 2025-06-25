package unicore.accesslog.model;

import lombok.Builder;
import lombok.Data;

import java.sql.Timestamp;

@Data
@Builder
public class AccessLog {
    private Long id;
    private String username;
    private Timestamp accessTime;
    private String ipAddress;
    private String userAgent;
    private String requestUri;
    private String httpMethod;
    private int responseStatus;
    private String loginSuccess;  // 성공: true, 실패: false
}
