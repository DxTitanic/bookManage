
<template>
<div  class="login-container"  >
    <el-form ref="form" :model="form"   :rules="rules" class="login-page">
      <h2 class="title" style="margin-bottom: 20px">图书管理系统登录</h2>
      <el-form-item prop="username" >
        <el-input v-model="form.username" placeholder="请输入用户名" clearable>
          <template #prefix>
            <el-icon class="el-input__icon"><User /></el-icon>
          </template>
        </el-input>
      </el-form-item>
      <el-form-item prop="password">
        <el-input v-model="form.password" placeholder="请输入密码" clearable show-password>
          <template #prefix>
            <el-icon class="el-input__icon"><Lock /></el-icon>
          </template>
        </el-input>
      </el-form-item>

      <el-form-item prop="role">
        <el-radio-group v-model="form.role">
          <el-radio label="2">用户</el-radio>
          <el-radio label="1">管理员</el-radio>
        </el-radio-group>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" style="width: 100%" @click="login">登 录</el-button>
      </el-form-item>
      <el-form-item><el-button type="text" @click="$router.push('/register')">前往注册 >> </el-button></el-form-item>
    </el-form>
</div>
</template>

<script>
import request from "../utils/request";
import {ElMessage} from "element-plus";
export default {
  name: "Login",
  data() {
    return {
      form: {
        role: '2' // 默认选中用户
      },
      rules: {
        username: [
          {
            required: true,
            message: '请输入用户名',
            trigger: 'blur',
          }
        ],
        password: [
          {
            required: true,
            message: '请输入密码',
            trigger: 'blur',
          }
        ]
      }
    }
  },
  methods: {
    login(){
      this.$refs['form'].validate((valid) => {
        if (valid) {
          request.post("user/login", this.form).then(res => {
            if (res.code == 0) {
              // 检查角色是否匹配
              if (res.data.role == this.form.role) {
                ElMessage.success("登录成功")
                sessionStorage.setItem("user",JSON.stringify(res.data))
                // 设置管理员状态
                this.$store.commit('announcement/SET_ADMIN', +res.data.role === 1)
                // /dashboard 图表展示页面，管理员用户页面
                if (res.data.role === 1) {
                  this.$router.push("/dashboard")
                } else {
                  this.$router.push("/home")
                }
              } else {
                ElMessage.error("角色选择与账号类型不匹配")
              }
            } else {
              ElMessage.error(res.msg)
            }
          })
        }
      })
    }
  }
}
</script>

<style scoped>
.login-container {
  position: fixed;
  width: 100%;
  height: 100vh;
  background: url('../img/bg2.svg');
  background-size: contain;
  overflow: hidden;
}
.login-page {
  border-radius: 5px;
  margin: 180px auto;
  width: 350px;
  padding: 35px 35px 15px;
  background: #fff;
  border: 1px solid #eaeaea;
  box-shadow: 0 0 25px #cac6c6;
}
</style>
