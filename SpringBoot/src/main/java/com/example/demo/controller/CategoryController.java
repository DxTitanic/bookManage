
package com.example.demo.controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.StringUtils;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.demo.commom.Result;
import com.example.demo.entity.Book;
import com.example.demo.entity.Category;
import com.example.demo.mapper.CategoryMapper;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

@RestController
@RequestMapping("/category")
public class CategoryController {
    @Resource
    CategoryMapper CategoryMapper;

    @PostMapping
    public Result<?> save(@RequestBody Category Category) {
        CategoryMapper.insert(Category);
        return Result.success();
    }

    @PutMapping
    public Result<?> update(@RequestBody Category Category) {
        CategoryMapper.updateById(Category);
        return Result.success();
    }

    @DeleteMapping("/{id}")
    public Result<?> delete(@PathVariable Long id) {
        CategoryMapper.deleteById(id);
        return Result.success();
    }


    @GetMapping
    public Result<?> findPage(@RequestParam(defaultValue = "1") Integer pageNum,
                             @RequestParam(defaultValue = "10") Integer pageSize,
                             @RequestParam(defaultValue = "") String search) {
        LambdaQueryWrapper<Category> wrappers = Wrappers.<Category>lambdaQuery();
         if(StringUtils.isNotBlank(search)){
            wrappers.like(Category::getName,search);
        }
        Page<Category> CategoryPage = CategoryMapper.selectPage(new Page<>(pageNum, pageSize), wrappers);
        return Result.success(CategoryPage);
    }

}
