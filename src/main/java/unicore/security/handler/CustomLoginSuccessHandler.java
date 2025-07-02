package unicore.security.handler;

import lombok.extern.slf4j.Slf4j;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

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
@Slf4j
public class CustomLoginSuccessHandler extends SimpleUrlAuthenticationSuccessHandler {

    private final AccessLogService accessLogService;

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
                                        Authentication authentication) throws IOException, ServletException {

        AccessLog accessLog = AccessLog.builder()
                .username(authentication.getName())
                .accessTime(new Timestamp(System.currentTimeMillis()))
                .ipAddress(request.getRemoteAddr())
                .userAgent(request.getHeader("User-Agent"))
                .requestUri(request.getRequestURI())
                .httpMethod("POST")
                .responseStatus(200)
                .loginSuccess("Y")
                .build();

        accessLogService.save(accessLog);

        log.debug("AccessLog = {}", accessLog);

        super.onAuthenticationSuccess(request, response, authentication);  // 리다이렉트 처리
    }


}
