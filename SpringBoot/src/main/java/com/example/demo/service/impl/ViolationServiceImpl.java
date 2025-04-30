
package com.example.demo.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.example.demo.entity.Violation;
import com.example.demo.mapper.ViolationMapper;
import com.example.demo.service.ViolationService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class ViolationServiceImpl implements ViolationService {
    @Resource
    private ViolationMapper violationMapper;

    @Override
    public List<Violation> getViolationRecords(Integer userId) {
        QueryWrapper<Violation> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("user_id", userId);
        return violationMapper.selectList(queryWrapper);
    }
}
