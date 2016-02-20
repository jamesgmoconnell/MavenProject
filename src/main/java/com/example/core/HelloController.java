package com.example.core;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HelloController {
	
	@RequestMapping("/hello")
	public String hello() {
		return "Hello! ";
	}
	
	@RequestMapping("/goodbye")
		public String goodbye() {
		return "Goodbye!";
	}
}

