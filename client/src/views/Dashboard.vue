<template>
  <div>
    <el-row :gutter="20">
      <el-col :span="6" v-for="item in cards" :key="item.title">
        <el-card class="box-card">
          <div slot="header" class="clearfix">{{ item.title }}</div>
          <div class="text item">
            <svg class="icon" aria-hidden="true">
              <use :xlink:href="item.icon" style="width: 100px"></use>
            </svg>
            <span class="text">{{ item.data }}</span>
          </div>
        </el-card>
      </el-col>
    </el-row>
    <div id="myTimer" style="margin-left: 15px;font-weight: 550;"></div>
    <!-- 左右排列的两个图表 -->
    <el-row :gutter="20" style="margin-top: 20px">
      <el-col :span="12">
        <el-card>
          <div id="main" style="width: 100%; height: 450px"></div>
        </el-card>
      </el-col>
      <el-col :span="12">
        <el-card>
          <div id="returnChart" style="width: 100%; height: 450px"></div>
        </el-card>
      </el-col>
    </el-row>
  </div>
</template>

<script>
import * as echarts from 'echarts'
import {ElMessage} from "element-plus";
import request from "../utils/request";

export default {
  data() {
    return {
      cards: [
        { title: '已借阅', data: 100, icon: '#iconlend-record-pro' },
        { title: '总访问', data: 100, icon: '#iconvisit'   },
        { title: '图书数', data: 100, icon: '#iconbook-pro' },
        { title: '用户数', data: 1000, icon: '#iconpopulation' }
      ],
      data:{}
    }
  },
  created() {

  },
  mounted() {
    this.circleTimer()

    request.get("/dashboard").then(res=>{
      if(res.code == 0)
      {
        this.cards[0].data = res.data.lendRecordCount
        this.cards[1].data = res.data.visitCount
        this.cards[2].data = res.data.bookCount
        this.cards[3].data = res.data.userCount
      }
      else
      {
        ElMessage.error(res.msg)
      }

      // 初始化统计图表
      var myChart = echarts.init(document.getElementById('main'))
      // 绘制图表
      myChart.setOption({
        title: {
          text: '统计'
        },
        tooltip: {
          trigger: 'axis'
          // axisPointer: {
          //   type: 'shadow' // 默认为直线，可选为：'line' | 'shadow'
          // }
        },
        grid: {
          left: '3%',
          right: '4%',
          bottom: '3%',
          containLabel: true
        },
        xAxis: {
          type: 'category',
          data: this.cards.map(item => item.title),
          axisTick: {
            alignWithLabel: true
          }
        },
        yAxis: {
          type: 'value'
        },
        series: [
          {
            type: 'bar',
            label: { show: true },
            barWidth: '25%',
            data: [
              {
                value: this.cards[0].data,
                itemStyle: { color: '#5470c6' }
              },
              {
                value: this.cards[1].data,
                itemStyle: { color: '#91cc75' }
              },
              {
                value: this.cards[2].data,
                itemStyle: { color: '#fac858' }
              },
              {
                value: this.cards[3].data,
                itemStyle: { color: '#ee6666' }
              }
            ]
          }
        ]
      })

    // 初始化归还和逾期图表(写死数据)
      var returnChart = echarts.init(document.getElementById('returnChart'))
      returnChart.setOption({
        title: {
          text: '归还与逾期统计'
        },
        tooltip: {
          trigger: 'axis'
        },
        legend: {
          data: ['归还数量', '逾期数量']
        },
        grid: {
          left: '3%',
          right: '4%',
          bottom: '3%',
          containLabel: true
        },
        xAxis: {
          type: 'category',
          data: ['周一', '周二', '周三', '周四', '周五', '周六', '周日']
        },
        yAxis: {
          type: 'value'
        },
        series: [
          {
            name: '归还数量',
            type: 'bar',
            data: [120, 132, 101, 134, 90, 230, 210],
            itemStyle: { color: '#67C23A' }
          },
          {
            name: '逾期数量',
            type: 'bar',
            data: [2, 1, 2, 3, 6, 0, 5],
            itemStyle: { color: '#F56C6C' }
          }
        ]
      })

      // 响应式调整
      const handleResize = () => {
        myChart && myChart.resize()
        returnChart && returnChart.resize()
      }
      window.addEventListener('resize', handleResize)
      this.$once('hook:beforeDestroy', () => {
        window.removeEventListener('resize', handleResize)
      })
    })
  },
  methods: {
    circleTimer() {
      this.getTimer()
      setInterval(() => {
        this.getTimer()
      }, 1000)
    },
    getTimer() {
      var d = new Date()
      var t = d.toLocaleString()
      document.getElementById('myTimer').innerHTML = t
    }
  }
}
</script>

<style scoped>
.box-card {
   width: 80%;
  margin-bottom: 25px;
  margin-left: 10px;
}

.clearfix {
  text-align: center;
  font-size: 15px;
}

.text {
  text-align: center;
  font-size: 24px;
  font-weight: 700;
  vertical-align: super;
}

#main {
  width: 100%;
  height: 450px;
  margin-top: 20px;
}

.icon {
  width: 50px;
  height: 50px;
  padding-top: 5px;
  padding-right: 10px;
}
</style>