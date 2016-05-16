package cn.sharetop.demo.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.dubbo.config.annotation.Reference;

import cn.sharetop.demo.api.Helloword;

@Controller
public class HelloController {

	@Reference(version="0.0.1")
	Helloword helloService;
	
	@RequestMapping(value = "/index", method = RequestMethod.GET, headers = { "Accept=text/html" })
	public ModelAndView index(@RequestParam(value="ln",defaultValue="en")String ln) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("index");
		
		String str = helloService.sayHello(ln);
		mv.addObject("message", str);
		return mv;
	}
	
}
