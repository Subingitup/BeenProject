package com.springbook.view.controller;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;

@ControllerAdvice
public class ExceptionController {

@ExceptionHandler(Exception.class)
public ModelAndView handleException(Exception e) {
	ModelAndView mav = new ModelAndView();
		mav.addObject("exception", e);
		mav.setViewName("/error/error3");;
		return mav;
	}
	
}
