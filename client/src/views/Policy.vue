
<template>
  <div>
    <div style="margin: 10px 0;margin-left: 15px">
      <el-input v-model="search" placeholder="请输入政策名称" style="width: 200px" clearable/>
      <el-button type="primary" style="margin-left: 5px" @click="load">查询</el-button>
      <el-button type="primary" @click="add">新增</el-button>
    </div>

    <el-table :data="tableData" border stripe style="width: 98%; margin-left: 15px">
      <el-table-column prop="id" label="ID" width="80" sortable/>
      <el-table-column prop="name" label="政策名称" width="120"/>
      <el-table-column prop="borrowDays" label="可借天数" width="100"/>
      <el-table-column prop="renewDays" label="可续借天数" width="100"/>
      <el-table-column prop="maxRenewTimes" label="最大续借次数" width="120"/>
      <el-table-column prop="finePerDay" label="每日罚金(元)" width="120"/>
      <el-table-column prop="createTime" label="创建时间" width="180"/>
      <el-table-column prop="updateTime" label="更新时间" width="180"/>
      <el-table-column label="操作" width="200">
        <template #default="scope">
          <el-button type="primary" @click="handleEdit(scope.row)">编辑</el-button>
          <el-popconfirm title="确认删除?" @confirm="handleDelete(scope.row.id)">
            <template #reference>
              <el-button type="danger">删除</el-button>
            </template>
          </el-popconfirm>
        </template>
      </el-table-column>
    </el-table>

    <div style="margin: 10px 0; margin-left: 15px">
      <el-pagination
          v-model:currentPage="currentPage"
          :page-size="pageSize"
          layout="total, prev, pager, next"
          :total="total"
          @current-change="load"
      />
    </div>

    <el-dialog v-model="dialogVisible" title="政策信息" width="30%">
      <el-form :model="form" label-width="120px">
        <el-form-item label="政策名称">
          <el-input v-model="form.name" style="width: 80%"/>
        </el-form-item>
        <el-form-item label="可借天数">
          <el-input-number v-model="form.borrowDays" :min="1" :max="365"/>
        </el-form-item>
        <el-form-item label="可续借天数">
          <el-input-number v-model="form.renewDays" :min="1" :max="365"/>
        </el-form-item>
        <el-form-item label="最大续借次数">
          <el-input-number v-model="form.maxRenewTimes" :min="0" :max="10"/>
        </el-form-item>
        <el-form-item label="每日罚金(元)">
          <el-input-number v-model="form.finePerDay" :min="0" :max="100" :precision="2"/>
        </el-form-item>
      </el-form>
      <template #footer>
        <span class="dialog-footer">
          <el-button @click="dialogVisible = false">取消</el-button>
          <el-button type="primary" @click="save">确认</el-button>
        </span>
      </template>
    </el-dialog>
  </div>
</template>

<script>
import request from "../utils/request";

export default {
  name: "Policy",
  data() {
    return {
      search: '',
      currentPage: 1,
      pageSize: 10,
      total: 0,
      tableData: [],
      form: {},
      dialogVisible: false
    }
  },
  created() {
    this.load()
  },
  methods: {
    load() {
      request.get("/policy", {
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
      this.dialogVisible = true
      this.form = {}
    },
    save() {
      if (this.form.id) {
        request.put("/policy", this.form).then(res => {
          if (res.code === '0') {
            this.$message.success("更新成功")
            this.load()
            this.dialogVisible = false
          } else {
            this.$message.error(res.msg)
          }
        })
      } else {
        request.post("/policy", this.form).then(res => {
          if (res.code === '0') {
            this.$message.success("新增成功")
            this.load()
            this.dialogVisible = false
          } else {
            this.$message.error(res.msg)
          }
        })
      }
    },
    handleEdit(row) {
      this.form = JSON.parse(JSON.stringify(row))
      this.dialogVisible = true
    },
    handleDelete(id) {
      request.delete("/policy/" + id).then(res => {
        if (res.code === '0') {
          this.$message.success("删除成功")
          this.load()
        } else {
          this.$message.error(res.msg)
        }
      })
    }
  }
}
</script>
