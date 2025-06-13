package unicore.security;


import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.web.configuration.*;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import unicore.security.CustomUserDetailsService;

@Configuration
@RequiredArgsConstructor
@EnableWebSecurity
public class SecurityConfig {

    private final CustomUserDetailsService userDetailsService;

    @Bean
    public BCryptPasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    public DaoAuthenticationProvider authenticationProvider() {
        DaoAuthenticationProvider provider = new DaoAuthenticationProvider();
        provider.setPasswordEncoder(passwordEncoder());
        provider.setUserDetailsService(userDetailsService);
        return provider;
    }

    // 3) 보안 필터 체인 설정
    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http
                .csrf().disable()   // CSRF 비활성화 (필요하다면 별도 토큰 처리)
                .authorizeRequests()
                // 로그인 페이지와 정적 리소스는 모두 허용
                .antMatchers(
                        "/login",
                        "/static/**",    // CSS, JS, 이미지 등
                        "/favicon.ico"
                ).permitAll()
                // 그 외 모든 요청은 인증된 사용자만 접근 가능
                .anyRequest().authenticated()
                .and()
                .formLogin()
                .loginPage("/login")                 // 사용자 정의 로그인 폼
                .loginProcessingUrl("/login")        // POST 처리 URL (기본값과 동일)
                .defaultSuccessUrl("/dashboard.do", true)
                .permitAll()
                .and()
                .logout()
                .logoutUrl("/logout")                // POST /logout 처리
                .logoutSuccessUrl("/login?logout")
                .permitAll();

        return http.build();
    }
}
