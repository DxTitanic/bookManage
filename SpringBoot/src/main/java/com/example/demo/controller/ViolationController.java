
package com.example.demo.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.core.toolkit.StringUtils;
import com.example.demo.commom.Result;
import com.example.demo.entity.Violation;
import com.example.demo.mapper.ViolationMapper;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

@RestController
@RequestMapping("/violation")
public class ViolationController {
    @Resource
    private ViolationMapper violationMapper;

    // 按用户查询违规记录
    @GetMapping("/records")
    public Result<List<Violation>> getViolationRecords(@RequestParam Integer userId) {
        QueryWrapper<Violation> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("user_id", userId);
        return Result.success(violationMapper.selectList(queryWrapper));
    }

    // 查询所有违规记录(支持分页和条件查询)
    @GetMapping
    public Result<Page<Violation>> getAllViolations(
            @RequestParam(defaultValue = "1") Integer pageNum,
            @RequestParam(defaultValue = "10") Integer pageSize,
            @RequestParam(required = false) String userId,
            @RequestParam(required = false) String bookName,
            @RequestParam(required = false) String status) {
        
        Page<Violation> page = new Page<>(pageNum, pageSize);
        QueryWrapper<Violation> queryWrapper = new QueryWrapper<>();
        
        if (StringUtils.isNotBlank(userId)) {
            queryWrapper.eq("user_id", userId);
        }
        if (StringUtils.isNotBlank(bookName)) {
            queryWrapper.like("book_name", bookName);
        }
        if (StringUtils.isNotBlank(status)) {
            queryWrapper.eq("status", status);
        }
        
        return Result.success(violationMapper.selectPage(page, queryWrapper));
    }
}
