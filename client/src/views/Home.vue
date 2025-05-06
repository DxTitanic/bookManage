
<template>
  <div class="home-container">
    <div class="header">
      <h1 class="main-title">欢迎来到智慧图书馆</h1>
      <p class="sub-title">探索知识海洋，享受阅读乐趣</p>
    </div>
    <el-carousel :interval="4000" height="60vh" type="card">
      <el-carousel-item v-for="item in carouselItems" :key="item.id">
        <div class="carousel-item">
          <img :src="item.image" class="carousel-image">
          <!-- <div class="carousel-title">{{ item.title }}</div> -->
        </div>
      </el-carousel-item>
    </el-carousel>
    
    <div class="footer-section">
      <img :src="footerBgImage" class="footer-bg" alt="底部背景">
      <div class="footer-content">
        <div class="footer-column">
          <h3>开放时间</h3>
          <p>周一至周日: 07:00 - 22:30</p>
          <p>人工服务: 08:00 - 21:30</p>
        </div>
        <div class="footer-column">
          <h3>友情链接</h3>
          <div class="links">
            <a v-for="(link, index) in friendLinks" :key="index" :href="link.url">{{ link.name }}</a>
          </div>
        </div>
      </div>
      <div class="copyright">
        <p>© 2025 智慧图书馆 | 电话: 12345678 | 邮箱: aaaaaaaaa@example.com</p>
      </div>
    </div>
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
      ],
      friendLinks: [
        { name: '国家图书馆', url: 'https://www.nlc.cn/' },
        { name: 'CALIS', url: 'http://www.calis.edu.cn/' },
        { name: 'CADAL', url: 'http://www.cadal.cn/' }
      ],
      qrCodes: [
        { name: '官方微信', image: require('@/assets/qrcode1.png') },
        { name: '移动图书馆', image: require('@/assets/qrcode2.png') }
      ],
      headerBgImage: require('@/assets/headBgImage.png'),
      footerBgImage: require('@/assets/backBgImage.png'),
    }
  }
}
</script>

<style scoped>
.home-container {
  padding: 20px;
  margin: 0;
  min-height: 100vh;
  background: linear-gradient(to bottom, #f5f7fa, #e4e8eb);
  position: relative;
}

.header {
  text-align: center;
  margin-bottom: 40px;
  padding-top: 30px;
  position: relative;
}

.header-bg {
  position: absolute;
  left: 20px;
  top: 20px;
  width: 80px;
  height: 80px;
  cursor: pointer;
  transition: transform 0.3s;
}

.header-bg:hover {
  transform: scale(1.1);
}

.header-bg img {
  width: 100%;
  height: 100%;
  object-fit: contain;
}

.main-title {
  font-size: 2.5rem;
  color: #2c3e50;
  margin-bottom: 15px;
  font-weight: 600;
}

.sub-title {
  font-size: 1.2rem;
  color: #7f8c8d;
  margin: 0;
}

.carousel-item {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  height: 100%;
  position: relative;
  border-radius: 8px;
  overflow: hidden;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
}

.carousel-image {
  width: 100%;
  height: 100%;
  object-fit: cover;
  position: absolute;
  top: 0;
  left: 0;
  transition: transform 0.3s ease;
}

.carousel-item:hover .carousel-image {
  transform: scale(1.05);
}

.carousel-title {
  position: absolute;
  bottom: 30px;
  left: 0;
  right: 0;
  text-align: center;
  font-size: 1.5rem;
  color: white;
  text-shadow: 0 2px 4px rgba(0, 0, 0, 0.5);
  padding: 10px;
  background: rgba(0, 0, 0, 0.5);
}

.footer-section {
  position: relative;
  margin-top: 50px;
  width: 100%;
}

.footer-bg {
  width: 100%;
  height: auto;
  opacity: 0.8;
  filter: brightness(0.8);
}

.footer-content {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  display: flex;
  justify-content: space-around;
  align-items: center;
  padding: 0 10%;
  color: #333;
  background-color: rgba(255, 255, 255, 0.7);
  backdrop-filter: blur(2px);
}

.footer-column {
  flex: 1;
  padding: 20px;
  text-align: center;
}

.footer-column h3 {
  font-size: 1.2rem;
  margin-bottom: 15px;
  color: #2c3e50;
}

.links a {
  display: block;
  margin: 8px 0;
  color: #333;
  text-decoration: none;
}

.links a:hover {
  color: #409eff;
}

.qrcodes {
  display: flex;
  justify-content: center;
  gap: 20px;
}

.qrcode-item {
  text-align: center;
}

.qrcode-item img {
  width: 80px;
  height: 80px;
  margin-bottom: 5px;
}

.copyright {
  position: absolute;
  bottom: 10px;
  width: 100%;
  text-align: center;
  font-size: 0.9rem;
  color: #666;
}
</style>
