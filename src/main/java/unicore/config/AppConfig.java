package unicore.config;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Import;

@Configuration
@ComponentScan(basePackages = "unicore")
@Import({DataSourceConfig.class})
public class AppConfig {
}
