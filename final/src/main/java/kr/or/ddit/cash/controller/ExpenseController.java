package kr.or.ddit.cash.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/cash")  // URL 매핑
public class ExpenseController {

    @GetMapping("/expenseReport")
    public String expenseReport() {
        return "cash/expenseReport";  // JSP 파일의 논리적 경로
    }
}

