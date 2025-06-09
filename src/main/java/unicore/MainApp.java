package unicore;

import org.springframework.context.annotation.AnnotationConfigApplicationContext;
import unicore.config.AppConfig;
import unicore.service.MyService;

public class MainApp {
    public static void main(String[] args) {
        AnnotationConfigApplicationContext context =
                new AnnotationConfigApplicationContext(AppConfig.class);

        MyService service = context.getBean(MyService.class);
        service.doSomething();

        context.close();
    }
}
