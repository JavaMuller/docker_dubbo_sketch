package cn.sharetop.demo.provider;

import java.util.ArrayList;
import java.util.List;

import org.springframework.context.support.FileSystemXmlApplicationContext;

import com.alibaba.dubbo.common.logger.Logger;
import com.alibaba.dubbo.common.logger.LoggerFactory;

/**
 * 基于Spring框架，通用的启动类
 * @author yancheng
 * @version 0.0.1
 *
 */
public class App 
{
	
	private static final Logger logger = LoggerFactory.getLogger(App.class);

    private static volatile boolean running = true;
    
    public static void main( String[] args )
    {
        List<String> configs =  new ArrayList<String>();
		
		if( args!=null ){
			for(String arg : args)
				configs.add(arg);
		}
		/**
		 * 采用FileSystemXmlApplicationContext，因为配置文件不打算放到classpath下
		 * 而是通过命令行指定所需要的XML文件来加载配置
		 * 
		 * */
		@SuppressWarnings("resource")
		final FileSystemXmlApplicationContext context = new FileSystemXmlApplicationContext(configs.toArray(new String[configs.size()]));
		context.start();
		
		/**
		 * 以下参考Dubbo的示例，处理kill的回调，以实现『优雅停机』
		 * 
		 * */
		Runtime.getRuntime().addShutdownHook(new Thread() {
            @Override
			public void run() {
                try {
                        context.stop();
                        logger.info("Dubbo stopped!");
                    } catch (Throwable t) {
                        logger.error(t.getMessage(), t);
                    }
                    synchronized (App.class) {
                        running = false;
                        App.class.notify();
                    }
                }
        });
		
		synchronized (App.class) {
	            while (running) {
	                try {
	                    App.class.wait();
	                } catch (Throwable e) {
	                }
	            }
	        }
    	}
}
