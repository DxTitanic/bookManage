
<template>
  <div class="announcement-container">
    <h2>图书馆公告</h2>
    <div class="announcement-list">
      <div class="announcement-item" v-for="(item, index) in announcements" :key="index">
        <h3>{{ item.title }}</h3>
        <p>{{ item.content }}</p>
        <p class="announcement-time">{{ item.time }}</p>
        <hr v-if="index < announcements.length - 1" class="announcement-divider">
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'Announcement',
  data() {
    return {
      announcements: [
        {
          title: '五一假期开馆时间安排',
          content: '5月1日至5月3日闭馆，5月4日起正常开放',
          time: '2023-04-28'
        },
        {
          title: '系统维护通知',
          content: '4月30日凌晨2:00-4:00进行系统维护，期间无法借阅图书',
          time: '2023-04-25'
        }
      ]
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
