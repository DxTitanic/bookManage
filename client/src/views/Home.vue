
<template>
  <div class="home-container">
    <el-carousel :interval="4000" style="height: 100vh;top: 300px;" type="card">
      <el-carousel-item v-for="item in carouselItems" :key="item.id">
        <div class="carousel-item">
          <img :src="item.image" class="carousel-image">
          <div class="carousel-title">{{ item.title }}</div>
        </div>
      </el-carousel-item>
    </el-carousel>
  </div>
</template>

<script>
export default {
  name: 'Home',
  data() {
    return {
      carouselItems: [
        { id: 2, title: '海量图书资源', image: 'https://lib.csu.edu.cn/images/22/06/28/40ldabf9g4/1.png' },
        { id: 3, title: '便捷借阅服务', image: 'https://lib.csu.edu.cn/images/22/06/28/40ldabf9g4/6.png' },
        { id: 4, title: '个人阅读空间', image: 'https://lib.csu.edu.cn/images/22/06/28/40ldabf9g4/2.png' }
      ]
    }
  }
}
</script>

<style scoped>
.home-container {
  padding: 0;
  margin: 0;
  height: 100vh;
  position: relative;
}

.carousel-item {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  height: 100%;
  position: relative;
}

.carousel-image {
  width: 100%;
  height: 100%;
  object-fit: cover;
  position: absolute;
  top: 0;
  left: 0;
}

.carousel-title {
  margin-top: 15px;
  font-size: 18px;
  color: #333;
}
</style>
