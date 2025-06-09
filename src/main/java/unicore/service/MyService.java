package unicore.service;

import org.springframework.stereotype.Service;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

@Service
public class MyService {

    private static final Logger logger = LogManager.getLogger(MyService.class);
    public void doSomething() {
        logger.info("Executing doSomething()");
        logger.debug("Debugging details here...");
    }
}
