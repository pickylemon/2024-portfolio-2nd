package com.portfolio.www.forum.notice.util;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.GenericXmlApplicationContext;

public class ApplicationContextCheck {
	public static void main(String[] args) {
		ApplicationContext ac = new GenericXmlApplicationContext("context-beans.xml");
		String[] beans = ac.getBeanDefinitionNames();
		for(String bean : beans) {
			System.out.println("beans="+ac.getBean("bean"));
		}
	}

}
