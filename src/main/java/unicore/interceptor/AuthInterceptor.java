package unicore.interceptor;


import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@Component
public class AuthInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) {
        // 현재 로그인 정보 가져오기
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();

        // 인증이 되어 있고, anonymousUser가 아닌 경우
        if (auth != null && auth.isAuthenticated() && !"anonymousUser".equals(auth.getPrincipal())) {
            HttpSession session = request.getSession();

            // 세션에 username 속성이 없다면 저장
            if (session.getAttribute("username") == null) {
                session.setAttribute("username", auth.getName());
            }
        }

        return true;
    }
}
