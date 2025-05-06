
<template>
  <el-card class="violation-card">
    <template #header>
      <div class="card-header">
        <el-icon><Failed /></el-icon>
        <span>违章信息</span>
        <div v-if="+user.role === 1" style="margin-left: auto">
          <el-form inline :model="searchForm" size="small">
            <el-form-item label="用户ID">
              <el-input v-model="searchForm.userId" placeholder="用户ID" clearable />
            </el-form-item>
            <el-form-item label="图书名称">
              <el-input v-model="searchForm.bookName" placeholder="图书名称" clearable />
            </el-form-item>
            <el-form-item label="处理状态">
              <el-select v-model="searchForm.status" placeholder="全部" clearable>
                <el-option label="已处理" value="已处理" />
                <el-option label="未处理" value="未处理" />
              </el-select>
            </el-form-item>
            <el-form-item>
              <el-button type="primary" @click="handleSearch">查询</el-button>
              <el-button @click="resetSearch">重置</el-button>
            </el-form-item>
          </el-form>
        </div>
      </div>
    </template>
    
    <el-table :data="violationData" border style="width: 100%">
      <el-table-column v-if="+user.role === 1" prop="userId" label="用户ID" width="120" />
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

    <!-- 分页 -->
    <div style="margin: 20px 0" v-if="+user.role === 1">
      <el-pagination
          v-model:current-page="pagination.currentPage"
          v-model:page-size="pagination.pageSize"
          :page-sizes="[10, 20, 50, 100]"
          layout="total, sizes, prev, pager, next, jumper"
          :total="pagination.total"
          @size-change="fetchViolationData"
          @current-change="fetchViolationData"
      />
    </div>
  </el-card>
</template>

<script>
import { Failed } from '@element-plus/icons-vue'
import request from "@/utils/request"

export default {
  name: 'Violation',
  components: { Failed },
  data() {
    return {
      violationData: [],
      form: {},
      user: {},
      searchForm: {
        userId: '',
        bookName: '',
        status: ''
      },
      pagination: {
        currentPage: 1,
        pageSize: 10,
        total: 0
      }
    }
  },
  created() {
    let str = sessionStorage.getItem("user") || "{}"
    this.user = JSON.parse(str)
    this.form = JSON.parse(str)
    this.fetchViolationData()
  },
  methods: {
    fetchViolationData() {
      if (+this.user.role === 1) {

        // 输入查询条件，可以查询单个用户的违章记录
        if(this.searchForm.userId || this.searchForm.bookName || this.searchForm.status) {

        }
        // 管理员查询所有记录
        request.get('/violation', {
          params: {
            ...this.searchForm,
            pageNum: this.pagination.currentPage,
            pageSize: this.pagination.pageSize
          }
        }).then(res => {
          this.violationData = res.data?.records || []
          this.pagination.total = res.data?.total || 0
        }).catch(error => {
          console.error('获取违章记录失败:', error)
          this.$message.error('获取违章信息失败')
        })
      } else {
        // 普通用户查询自己的记录
        request.get('/violation/records', {
          params: { userId: this.form.id }
        }).then(res => {
          this.violationData = res.data || []
        }).catch(error => {
          console.error('获取违章记录失败:', error)
          this.$message.error('获取违章信息失败')
        })
      }
    },
    handleSearch() {
      this.fetchViolationData()
    },
    resetSearch() {
      this.searchForm = {
        userId: '',
        bookName: '',
        status: ''
      }
      this.fetchViolationData()
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
