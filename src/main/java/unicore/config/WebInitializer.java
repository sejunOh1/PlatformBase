package unicore.config;

import org.springframework.web.WebApplicationInitializer;
import org.springframework.web.context.support.AnnotationConfigWebApplicationContext;
import org.springframework.web.servlet.DispatcherServlet;

import javax.servlet.*;

public class WebInitializer implements WebApplicationInitializer {

    @Override
    public void onStartup(ServletContext servletContext) throws ServletException {

        // Spring MVC용 WebApplicationContext 생성
        AnnotationConfigWebApplicationContext ctx = new AnnotationConfigWebApplicationContext();
        ctx.register(AppConfig.class, WebMvcConfig.class);  // Spring MVC 설정 클래스

        // DispatcherServlet 등록
        ServletRegistration.Dynamic dispatcher = servletContext.addServlet("dispatcher", new DispatcherServlet(ctx));
        dispatcher.setLoadOnStartup(1);
        dispatcher.addMapping("/");
        dispatcher.addMapping("*.do");
    }

}
