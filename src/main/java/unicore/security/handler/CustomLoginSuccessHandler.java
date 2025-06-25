package unicore.security.handler;

import lombok.RequiredArgsConstructor;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationSuccessHandler;
import org.springframework.stereotype.Component;
import unicore.accesslog.model.AccessLog;
import unicore.accesslog.service.AccessLogService;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Timestamp;

@Component
@RequiredArgsConstructor
public class CustomLoginSuccessHandler extends SimpleUrlAuthenticationSuccessHandler {

    private final AccessLogService accessLogService;

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
                                        Authentication authentication) throws IOException, ServletException {

        Timestamp now = new Timestamp(System.currentTimeMillis());

        AccessLog log = AccessLog.builder()
                .username(authentication.getName())
                .accessTime(now)
                .ipAddress(request.getRemoteAddr())
                .userAgent(request.getHeader("User-Agent"))
                .requestUri("/login")
                .httpMethod("POST")
                .responseStatus(200)
                .loginSuccess("Y")
                .build();

        System.out.println("🧪 AccessLog = " + log);

        accessLogService.save(log);  // → DB 저장

        super.onAuthenticationSuccess(request, response, authentication);  // 리다이렉트 처리
    }


}
