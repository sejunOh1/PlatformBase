package unicore.accesslog.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.sql.Timestamp;

@Data
@NoArgsConstructor
@AllArgsConstructor
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
    private String loginSuccess;
}
