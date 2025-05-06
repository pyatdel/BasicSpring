package kr.or.ddit.chat.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/chat")
public class ChatController {
    
    @GetMapping
    public void connect() {
        log.info("chat socket connected...");
    }
}