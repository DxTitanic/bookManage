
package com.example.demo.controller;

import com.example.demo.common.Result;
import com.example.demo.entity.Violation;
import com.example.demo.service.ViolationService;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

@RestController
@RequestMapping("/api/violation")
public class ViolationController {
    @Resource
    private ViolationService violationService;

    @GetMapping("/records")
    public Result<List<Violation>> getViolationRecords(@RequestParam Integer userId) {
        return Result.success(violationService.getViolationRecords(userId));
    }
}
