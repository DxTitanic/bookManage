
package com.example.demo.controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.demo.commom.Result;
import com.example.demo.entity.Policy;
import com.example.demo.mapper.PolicyMapper;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.Date;

@RestController
@RequestMapping("/policy")
public class PolicyController {
    @Resource
    private PolicyMapper policyMapper;

    @PostMapping
    public Result<?> save(@RequestBody Policy policy) {
        policy.setCreateTime(new Date());
        policy.setUpdateTime(new Date());
        policyMapper.insert(policy);
        return Result.success();
    }

    @PutMapping
    public Result<?> update(@RequestBody Policy policy) {
        policy.setUpdateTime(new Date());
        policyMapper.updateById(policy);
        return Result.success();
    }

    @DeleteMapping("/{id}")
    public Result<?> delete(@PathVariable Integer id) {
        policyMapper.deleteById(id);
        return Result.success();
    }

    @GetMapping
    public Result<?> findPage(@RequestParam(defaultValue = "1") Integer pageNum,
                             @RequestParam(defaultValue = "10") Integer pageSize,
                             @RequestParam(defaultValue = "") String search) {
        LambdaQueryWrapper<Policy> wrapper = Wrappers.lambdaQuery();
        if (!search.isEmpty()) {
            wrapper.like(Policy::getName, search);
        }
        Page<Policy> policyPage = policyMapper.selectPage(new Page<>(pageNum, pageSize), wrapper);
        return Result.success(policyPage);
    }
}
