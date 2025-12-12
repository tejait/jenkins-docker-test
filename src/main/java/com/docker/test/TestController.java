package com.docker.test;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("test")
public class TestController {

    @GetMapping("hello")
    public String hello() {
        return "Hello from TestController";
    }
    @GetMapping("hi")
    public String hi() {
        System.out.println("Hi endpoint was called");
        System.out.println("Hi Hello");
        return "Hi from TestController";
    }
}
