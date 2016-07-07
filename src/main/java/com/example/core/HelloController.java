package com.example.core;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HelloController {
	
	@RequestMapping("/hello")
	public String hello() {
		return "Allo Allo!\n";
	}
	
	@RequestMapping("/monday")
	public String monday() {
		return "monday!\n";
	}
	
	@RequestMapping("/tuesday")
	public String tuesday() {
		return "tuesday!\n";
	}
	
	@RequestMapping("/wednesday")
	public String wednesday() {
		return "wednesday!\n";
	}
	
	@RequestMapping("/thursday")
	public String thursday() {
		return "thursday!\n";
	}
	
	@RequestMapping("/friday")
	public String friday() {
		return "friday!\n";
	}
	
	@RequestMapping("/saturday")
	public String saturday() {
		return "saturday!\n";
	}
	
	@RequestMapping("/sunday")
	public String sunday() {
		return "sunday!\n";
	}
	
	@RequestMapping("/goodbye")
		public String goodbye() {
		return "Goodbye!\n";
	}
}

