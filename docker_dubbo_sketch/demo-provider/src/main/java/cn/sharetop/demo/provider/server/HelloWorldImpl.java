package cn.sharetop.demo.provider.server;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.StringUtils;

import com.alibaba.dubbo.config.annotation.Service;

import cn.sharetop.demo.api.Helloword;
import cn.sharetop.demo.provider.AppConfig;

@Service(version="0.0.1")
public class HelloWorldImpl implements Helloword{

	@Autowired
	AppConfig appConfig;
	
	public String sayHello(String local) {
		// TODO Auto-generated method stub
		String str = appConfig.getLanguage().get(local);
		if(StringUtils.isEmpty(str))
			return appConfig.getLanguage().get("en");
		
		return str;
	}

	public String sayHello() {
		// TODO Auto-generated method stub
		return appConfig.getLanguage().get("en");
	}
	
}
