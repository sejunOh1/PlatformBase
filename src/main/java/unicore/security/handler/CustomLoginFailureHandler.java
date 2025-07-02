package unicore.security.handler;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.stereotype.Component;
import unicore.accesslog.model.AccessLog;
import unicore.accesslog.service.AccessLogService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Timestamp;

@Component
@RequiredArgsConstructor
@Slf4j
public class CustomLoginFailureHandler implements AuthenticationFailureHandler {
    private final AccessLogService accessLogService;

    @Override
    public void onAuthenticationFailure(HttpServletRequest request,
                                        HttpServletResponse response,
                                        AuthenticationException exception) throws IOException {

        AccessLog accessLog = AccessLog.builder()
                .username(request.getParameter("username"))  // 로그인 시도한 사용자 아이디
                .accessTime(new Timestamp(System.currentTimeMillis()))
                .ipAddress(request.getRemoteAddr())
                .userAgent(request.getHeader("User-Agent"))
                .requestUri(request.getRequestURI())
                .httpMethod("POST")
                .responseStatus(HttpServletResponse.SC_UNAUTHORIZED) // 401
                .loginSuccess("N")
                .build();

        accessLogService.save(accessLog);
        log.warn("로그인 실패: {}", accessLog);

        // 로그인 실패 시 다시 로그인 페이지로 이동 (에러 파라미터 전달 가능)
        response.sendRedirect("/login?error");
    }
}
