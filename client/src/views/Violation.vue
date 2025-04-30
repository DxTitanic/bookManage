
<template>
  <el-card class="violation-card">
    <template #header>
      <div class="card-header">
        <el-icon><Failed /></el-icon>
        <span style="margin-top: 15px;">违章信息</span>
      </div>
    </template>
    
    <el-table :data="violationData" border style="width: 100%">
      <el-table-column prop="bookName" label="图书名称" width="180" />
      <el-table-column prop="bookId" label="图书编号" width="120" />
      <el-table-column prop="violationType" label="违章类型" width="150">
        <template #default="scope">
          <el-tag :type="scope.row.violationType === '逾期未还' ? 'danger' : 'warning'">
            {{ scope.row.violationType }}
          </el-tag>
        </template>
      </el-table-column>
      <el-table-column prop="violationDate" label="违章日期" width="180" />
      <el-table-column prop="fineAmount" label="罚款金额(元)" width="120" />
      <el-table-column prop="status" label="处理状态" width="120">
        <template #default="scope">
          <el-tag :type="scope.row.status === '已处理' ? 'success' : 'info'">
            {{ scope.row.status }}
          </el-tag>
        </template>
      </el-table-column>
      <el-table-column prop="remarks" label="备注说明" />
    </el-table>
  </el-card>
</template>

<script>
import { Failed } from '@element-plus/icons-vue'
import { getViolationRecords } from '../api/violation'

export default {
  name: 'Violation',
  components: { Failed },
  data() {
    return {
      violationData: [],
      form: {}
    }
  },
  created() {
    let str = sessionStorage.getItem("user") || "{}"
    this.form = JSON.parse(str)
    this.fetchViolationData()
  },
  methods: {
    async fetchViolationData() {
      try {
        const res = await getViolationRecords(this.form.id)
        if (res.code === '0') {
          this.violationData = res.data
        }
      } catch (error) {
        console.error('获取违章信息失败:', error)
      }
    }
  }
}
</script>

<style scoped>
.violation-card {
  margin: 20px;
}
.card-header {
  display: flex;
  align-items: center;
  gap: 10px;
  font-size: 18px;
  font-weight: bold;
}
</style>
