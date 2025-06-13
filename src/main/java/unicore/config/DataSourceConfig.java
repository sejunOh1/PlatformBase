package unicore.config;

import net.ttddyy.dsproxy.support.ProxyDataSourceBuilder;
import net.ttddyy.dsproxy.listener.logging.SLF4JQueryLoggingListener;
import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.*;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;
import org.springframework.jdbc.core.JdbcTemplate;

import javax.sql.DataSource;

@Configuration
@PropertySource("classpath:application.properties")
@MapperScan(basePackages = "unicore.**.mapper")
public class DataSourceConfig {

    @Value("${db.driverClassName}")
    private String driverClassName;

    @Value("${db.url}")
    private String url;

    @Value("${db.username}")
    private String username;

    @Value("${db.password}")
    private String password;

    /** 1. HikariCP 기반 DataSource */
    @Bean
    public DataSource dataSource() {
        HikariConfig cfg = new HikariConfig();
        cfg.setDriverClassName(driverClassName);
        cfg.setJdbcUrl(url);
        cfg.setUsername(username);
        cfg.setPassword(password);

        return new HikariDataSource(cfg);
    }

    /** 2. MyBatis용 SqlSessionFactory */
    @Bean
    public SqlSessionFactory sqlSessionFactory(DataSource dataSource) throws Exception {
        SqlSessionFactoryBean factoryBean = new SqlSessionFactoryBean();
        factoryBean.setDataSource(dataSource);

        //mybatis-config.xml 등록
        factoryBean.setConfigLocation(
                new PathMatchingResourcePatternResolver()
                        .getResource("classpath:mybatis-config.xml")
        );

        // mapper XML 파일 경로 지정
        factoryBean.setMapperLocations(
                new PathMatchingResourcePatternResolver().getResources("classpath:mapper/**/*.xml")
        );
        return factoryBean.getObject();
    }

}
