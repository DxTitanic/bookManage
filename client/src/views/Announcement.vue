
<template>
  <div class="announcement-container">
    <h2>图书馆公告</h2>
    
    <!-- 管理员添加公告表单 -->
    <el-card v-if="+this.user.role === 1" class="announcement-form">
      <el-form :model="newAnnouncement" @submit.prevent="handleSubmit">
        <el-form-item label="公告标题">
          <el-input v-model="newAnnouncement.title" placeholder="请输入标题"></el-input>
        </el-form-item>
        <el-form-item label="公告内容">
          <el-input 
            v-model="newAnnouncement.content" 
            type="textarea" 
            :rows="3"
            placeholder="请输入公告内容">
          </el-input>
        </el-form-item>
        <el-button type="primary" native-type="submit">发布公告</el-button>
      </el-form>
    </el-card>

    <!-- 公告列表 -->
    <div class="announcement-list">
      <el-card 
        v-for="(item, index) in announcements" 
        :key="item.id" 
        class="announcement-item"
        shadow="hover">
        <div style="display: flex; justify-content: space-between; align-items: center">
          <h3>{{ item.title }}</h3>
          <el-button 
            v-if="user.role == 1" 
            type="danger" 
            size="small" 
            @click="handleDelete(item.id)"
            style="margin-left: 10px">
            删除
          </el-button>
        </div>
        <p>{{ item.content }}</p>
        <p class="announcement-time">{{ item.createTime }}</p>
      </el-card>
    </div>
  </div>
</template>

<script>
import request from "../utils/request";

export default {
  name: 'Announcement',
  data() {
    return {
      newAnnouncement: {
        title: '',
        content: ''
      },
      announcements: [],
      user: {}
    }
  },
  created() {
    this.loadAnnouncements()
    let userStr = sessionStorage.getItem("user") || "{}"
    this.user = JSON.parse(userStr)
  },
  methods: {
    async loadAnnouncements() {
      try {
        const res = await request.get("/announcement")
        if (res.code === '0') {
          this.announcements = res.data.records.reverse()
        }
      } catch (error) {
        this.$message.error('获取公告失败')
      }
    },
    async handleSubmit() {
      try {
        const res = await request.post("/announcement", this.newAnnouncement)
        if (res.code === '0') {
          this.newAnnouncement = { title: '', content: '' }
          this.$message.success('公告发布成功')
          this.loadAnnouncements()
        } else {
          this.$message.error(res.msg)
        }
      } catch (error) {
        this.$message.error('发布公告失败')
      }
    },
    async handleDelete(id) {
      try {
        const res = await request.delete("/announcement/" + id)
        if (res.code === '0') {
          this.$message.success('删除成功')
          this.loadAnnouncements()
        } else {
          this.$message.error(res.msg)
        }
      } catch (error) {
        this.$message.error('删除公告失败')
      }
    }
  }
}
</script>

<style scoped>
.announcement-container {
  padding: 20px;
}

.announcement-list {
  margin-top: 20px;
}

.announcement-item {
  padding: 15px 0;
}

.announcement-item h3 {
  color: #333;
  margin-bottom: 8px;
}

.announcement-item p {
  color: #666;
  margin-bottom: 5px;
}

.announcement-time {
  color: #999;
  font-size: 12px;
}

.announcement-divider {
  border: none;
  border-top: 1px dashed #ddd;
  margin: 15px 0;
}

.announcement-item:hover h3,
.announcement-item:hover p {
  color: #999;
}
</style>
