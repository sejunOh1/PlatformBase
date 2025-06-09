package unicore.config;

import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.*;
import unicore.interceptor.AuthInterceptor;

@Configuration
@EnableWebMvc
@ComponentScan(basePackages = "unicore.controller")
public class WebMvcConfig implements WebMvcConfigurer {

    @Override
    public void configureViewResolvers(ViewResolverRegistry registry) {
        // JSP 파일이 위치한 폴더와 확장자 설정
        registry.jsp("/WEB-INF/views/", ".jsp");
    }

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry
                .addResourceHandler("/static/**")
                .addResourceLocations("/static/");
    }

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(new AuthInterceptor())
                .addPathPatterns("/**") // 모든 요청에 적용
                .excludePathPatterns("/login", "/logout", "/static/**", "/error"); // 로그인 제외
    }
}
