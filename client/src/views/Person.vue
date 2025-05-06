<template>
  <div style="display: flex; gap: 20px; padding: 20px;">
    <el-card style="flex: 1; min-width: 0;">
        <h2 style="padding: 30px">个人信息</h2>
      <el-form :model="form" ref="form" label-width="80px">
        <el-form-item label="用户名">
          <el-input style="width: 80%" v-model="form.username" disabled></el-input>
        </el-form-item>
        <el-form-item label="姓名">
          <el-input style="width: 80%" v-model="form.nickName"></el-input>
        </el-form-item>
        <el-form-item label="权限">
            <span v-if="form.role==1" style="margin:5px">管理员</span>
            <span v-if="form.role==2" style="margin:5px">读者</span>
        </el-form-item>
        <el-form-item label="电话号码">
          <el-input style="width: 80%" v-model="form.phone"></el-input>
        </el-form-item>
        <el-form-item label="性别">
          <div>
            <el-radio v-model="form.sex" label="男">男</el-radio>
            <el-radio v-model="form.sex" label="女">女</el-radio>
          </div>
        </el-form-item>
        <el-form-item label="地址">
          <el-input type="textarea" style="width: 80%" v-model="form.address"></el-input>
        </el-form-item>
      </el-form>
      <div style="text-align: center">
        <el-button type="primary" @click="update">保存</el-button>
      </div>
    </el-card>

    <el-card class="lend-record-card" shadow="hover" style="flex: 1; min-width: 0;">
      <template #header>
        <div class="card-header">
          <span>我的借阅记录</span>
        </div>
      </template>
      <el-table
        :data="lendRecords"
        style="width: 100%"
        border
        stripe
        :header-cell-style="{background:'#f5f7fa',color:'#606266'}"
      >
        <el-table-column prop="bookName" label="图书名称" width="180" />
        <el-table-column prop="lendDate" label="借阅日期" width="180" />
        <el-table-column prop="returnDate" label="应还日期" />
        <el-table-column prop="status" label="状态">
          <template #default="scope">
            <el-tag :type="scope.row.status === '已归还' ? 'success' : 'warning'">
              {{ scope.row.status }}
            </el-tag>
          </template>
        </el-table-column>
      </el-table>
    <div v-if="lendRecords.length > 9" style="text-align: center; margin-top: 15px;">
      <el-button type="primary" @click="goToLendRecords">查看更多借阅记录</el-button>
    </div>
    </el-card>
  </div>
</template>

<script>
import request from "@/utils/request";
import {ElMessage} from "element-plus";

export default {
  name: "Person",
  data() {
    return {
      form: {},
      lendRecords: [] // 借阅记录数据
    }
  },
  created() {
    let str = sessionStorage.getItem("user") || "{}"
    console.log(str, 'str', this.form)
    this.form = JSON.parse(str)
    this.fetchLendRecords()
  },
  methods: {
    update() {
      request.put("/user", this.form).then(res => {
        console.log(res)
        if (res.code === '0') {
          ElMessage.success("更新成功")
          sessionStorage.setItem("user", JSON.stringify(this.form))
          // 触发Layout更新用户信息
          this.$emit("userInfo")
        } else {
          ElMessage.error(res.msg)
        }
      })
    },
    fetchLendRecords() {
      // 只传必要的search3参数，其他使用接口默认值
      request.get("/LendRecord", {
        params: {
          search3: this.form.id
        }
      }).then(res => {
        if(res.code === '0') {
          this.lendRecords = res.data.records.map(record => ({
            bookName: record.bookname,
            lendDate: record.lendTime,
            returnDate: record.returnTime,
            status: +record.status === 1 ? '已归还' : '借阅中'
          }))
        }
      })
    },
    goToLendRecords() {
      this.$router.push('/lendrecord')  // 确保路径与侧边栏菜单一致
    }
  }
}
</script>

<style>
.avatar-uploader  {
  border: 1px dashed #d9d9d9;
  border-radius: 6px;
  cursor: pointer;
  position: relative;
  overflow: hidden;
}
.avatar-uploader:hover {
  border-color: #409EFF;
}

.avatar {
  width: 178px;
  height: 178px;
  display: block;
}
.box-card {
  width: 60%;
  margin: auto;
  padding: 20px;
}
</style>
