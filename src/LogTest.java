import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


public class LogTest {
	
	public static void main(String ar[]) {
		Logger  logger = LoggerFactory.getLogger(LogTest.class);
		logger.debug("main");
		logger.info("LogTest");
		logger.error("error");
		System.out.println("main");
	}
	

}
