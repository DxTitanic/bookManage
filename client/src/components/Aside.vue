<template>
<div>
  <el-menu
      style="width: 200px; min-height: calc(100vh - 50px);"
      :default-active="path"
      class="el-menu-vertical-demo"
      @open="handleOpen"
      @close="handleClose"
      router
      background-color="#30333c" text-color="#fff"
  >
    <el-menu-item :index="user.role == '1' ? '/dashboard' : '/home'" >
      <template v-if="user.role == '1'">
        <svg class="icon" aria-hidden="true">
          <use xlink:href="#icondashboard"></use>
        </svg>
      </template>
      <template v-else>
        <el-icon><HomeFilled /></el-icon>
      </template>
      <span v-if="user.role == '1'">展示板</span>
      <span v-else style="margin-top: 18px;">首页</span>
    </el-menu-item>
    <el-sub-menu index="2" text-color="#fff">
      <template #title>
        <svg class="icon" aria-hidden="true">
          <use xlink:href="#icon-mingpian "></use>
        </svg>
        <span>个人信息</span>
      </template>
      <el-menu-item index="/person" style="font-color: white">
        <svg class="icon" aria-hidden="true">
          <use xlink:href="#icon-a-bianji1 "></use>
        </svg>
        <span>修改个人信息</span>
      </el-menu-item>
      <!-- <el-menu-item index="/password">
        <svg class="icon" aria-hidden="true">
          <use xlink:href="#icon-mima "></use>
        </svg>
        <span>修改密码</span>
      </el-menu-item> -->
    </el-sub-menu>
    <el-menu-item index="/user" v-if="user.role == 1">
      <svg class="icon" aria-hidden="true">
        <use xlink:href="#iconreader "></use>
      </svg>
      <span>读者管理</span>
    </el-menu-item>
    <el-menu-item index="/book" v-if="user.role == 1" >
      <svg class="icon" aria-hidden="true">
        <use xlink:href="#iconbook "></use>
      </svg>
      <span>书籍管理</span>
    </el-menu-item>
    <el-menu-item index="/book" v-if="user.role == 2">
      <svg class="icon" aria-hidden="true">
        <use xlink:href="#iconbook "></use>
      </svg>
      <span>图书查询</span>
    </el-menu-item>
    <el-menu-item index="/lendrecord" v-if="user.role == 1">
      <svg class="icon" aria-hidden="true">
        <use xlink:href="#iconlend-record "></use>
      </svg>
      <span>借阅管理</span>
    </el-menu-item>
    <el-menu-item index="/lendrecord" v-if="user.role == 2">
      <svg class="icon" aria-hidden="true">
        <use xlink:href="#iconlend-record"></use>
      </svg>
      <span>借阅信息</span>
    </el-menu-item>
    <el-menu-item index="/bookwithuser" v-if="user.role == 1">
      <el-icon><grid /></el-icon>
      <span>借阅状态</span>
    </el-menu-item>
    <el-menu-item index="/announcement">
      <svg class="icon" aria-hidden="true">
        <use xlink:href="#iconreader "></use>
      </svg>
      <span>公告通知</span>
    </el-menu-item>
    <el-menu-item index="/violation" v-if="user.role == 1 || user.role == 2">
      <el-icon><Failed /></el-icon>
      <span style="margin-top: 15px;">违章信息</span>
    </el-menu-item>
    <el-menu-item index="/category" v-if="user.role == 1">
      <el-icon><Discount /></el-icon>
      <span style="margin-top: 15px;">分类信息维护</span>
    </el-menu-item>
    <el-menu-item index="/policy" v-if="user.role == 1">
      <el-icon><Document /></el-icon>
      <span style="margin-top: 15px;">借阅政策管理</span>
    </el-menu-item>
  </el-menu>

</div>
</template>

<script>



import { defineAsyncComponent } from 'vue';
export default {
  name: "Aside",
  components: {
    HomeFilled: defineAsyncComponent(() => import('@element-plus/icons-vue').then(mod => mod.HomeFilled)),
    Failed: defineAsyncComponent(() => import('@element-plus/icons-vue').then(mod => mod.Failed)),
    Discount: defineAsyncComponent(() => import('@element-plus/icons-vue').then(mod => mod.Discount)),
    Document: defineAsyncComponent(() => import('@element-plus/icons-vue').then(mod => mod.Document))
  },
  created(){
    let userStr = sessionStorage.getItem("user") ||"{}"
    this.user = JSON.parse(userStr)
  },
  data(){
    return {
      user:{},
      path: this.$route.path
    }
  },
  watch: {
    '$route'(to) {
      this.path = to.path
    }
  },
}
</script>

<style scoped>
.icon {
  width: 30px;
  height: 30px;
  padding-top: 5px;
  padding-right: 10px;
}
/* 
.el-icon {
  margin-right: 10px;
  vertical-align: middle;
} */
</style>