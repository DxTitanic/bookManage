
<template>
  <div class="home" style="padding: 10px">
    <!-- 搜索区域 -->
    <div style="margin: 10px 0;">
      <el-input v-model="search" placeholder="请输入分类名称" style="width: 20%" clearable />
      <el-button type="primary" style="margin-left: 5px" @click="load">查询</el-button>
      <el-button type="primary" @click="add">新增</el-button>
    </div>

    <!-- 数据表格 -->
    <el-table :data="tableData" stripe border style="width: 100%">
      <el-table-column prop="id" label="ID" sortable />
      <el-table-column prop="name" label="分类名称" />
      <el-table-column prop="createTime" label="创建时间" />
      <el-table-column label="操作" width="200">
        <template #default="scope">
          <el-button size="small" @click="handleEdit(scope.row)">编辑</el-button>
          <el-popconfirm title="确认删除?" @confirm="handleDelete(scope.row.id)">
            <template #reference>
              <el-button size="small" type="danger">删除</el-button>
            </template>
          </el-popconfirm>
        </template>
      </el-table-column>
    </el-table>

    <!-- 分页 -->
    <div style="margin: 10px 0">
      <el-pagination
          v-model:currentPage="currentPage"
          :page-sizes="[5, 10, 20]"
          :page-size="pageSize"
          layout="total, sizes, prev, pager, next, jumper"
          :total="total"
          @size-change="handleSizeChange"
          @current-change="handleCurrentChange"
      />
    </div>

    <!-- 新增/编辑对话框 -->
    <el-dialog v-model="dialogVisible" :title="dialogTitle" width="30%">
      <el-form :model="form" label-width="120px">
        <el-form-item label="分类名称">
          <el-input v-model="form.name" style="width: 80%" />
        </el-form-item>
      </el-form>
      <template #footer>
        <span class="dialog-footer">
          <el-button @click="dialogVisible = false">取消</el-button>
          <el-button type="primary" @click="save">确定</el-button>
        </span>
      </template>
    </el-dialog>
  </div>
</template>

<script>
import request from "../utils/request";
import {ElMessage} from "element-plus";

export default {
  name: 'Category',
  data() {
    return {
      search: '',
      currentPage: 1,
      pageSize: 10,
      total: 0,
      tableData: [],
      dialogVisible: false,
      dialogTitle: '',
      form: {}
    }
  },
  created() {
    this.load()
  },
  methods: {
    load() {
      request.get("/category", {
        params: {
          pageNum: this.currentPage,
          pageSize: this.pageSize,
          search: this.search
        }
      }).then(res => {
        this.tableData = res.data.records
        this.total = res.data.total
      })
    },
    add() {
      this.dialogTitle = "新增分类"
      this.form = {}
      this.dialogVisible = true
    },
    handleEdit(row) {
      this.dialogTitle = "编辑分类"
      this.form = JSON.parse(JSON.stringify(row))
      this.dialogVisible = true
    },
    save() {
      if (this.form.id) {
        request.put("/category", this.form).then(res => {
          if (res.code === '0') {
            ElMessage.success("更新成功")
            this.load()
            this.dialogVisible = false
          } else {
            ElMessage.error(res.msg)
          }
        })
      } else {
        request.post("/category", this.form).then(res => {
          if (res.code === '0') {
            ElMessage.success("新增成功")
            this.load()
            this.dialogVisible = false
          } else {
            ElMessage.error(res.msg)
          }
        })
      }
    },
    handleDelete(id) {
      request.delete("/category/" + id).then(res => {
        if (res.code === '0') {
          ElMessage.success("删除成功")
          this.load()
        } else {
          ElMessage.error(res.msg)
        }
      })
    },
    handleSizeChange(pageSize) {
      this.pageSize = pageSize
      this.load()
    },
    handleCurrentChange(pageNum) {
      this.currentPage = pageNum
      this.load()
    }
  }
}
</script>
