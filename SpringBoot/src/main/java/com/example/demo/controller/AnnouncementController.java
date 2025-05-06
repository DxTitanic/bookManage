
package com.example.demo.controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.demo.commom.Result;
import com.example.demo.entity.Announcement;
import com.example.demo.mapper.AnnouncementMapper;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.Date;

@RestController
@RequestMapping("/announcement")
public class AnnouncementController {
    @Resource
    private AnnouncementMapper announcementMapper;

    @PostMapping
    public Result<?> save(@RequestBody Announcement announcement) {
        announcement.setCreateTime(new Date());
        announcementMapper.insert(announcement);
        return Result.success();
    }

    @PutMapping
    public Result<?> update(@RequestBody Announcement announcement) {
        announcementMapper.updateById(announcement);
        return Result.success();
    }

    @DeleteMapping("/{id}")
    public Result<?> delete(@PathVariable Integer id) {
        announcementMapper.deleteById(id);
        return Result.success();
    }

    @GetMapping
    public Result<?> findPage(@RequestParam(defaultValue = "1") Integer pageNum,
                             @RequestParam(defaultValue = "10") Integer pageSize,
                             @RequestParam(defaultValue = "") String search) {
        LambdaQueryWrapper<Announcement> wrapper = Wrappers.lambdaQuery();
        if (!search.isEmpty()) {
            wrapper.like(Announcement::getTitle, search);
        }
        Page<Announcement> announcementPage = announcementMapper.selectPage(new Page<>(pageNum, pageSize), wrapper);
        return Result.success(announcementPage);
    }
}
