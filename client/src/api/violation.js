import request from '@/utils/request'

export function getViolationRecords(userId) {
  return request({
    url: '/violation/records',
    method: 'get',
    params: { userId }
  })
}

export const mockData = {
    // 这里是你的mock数据
    violationData: [
        {
          bookName: "Java编程思想",
          bookId: "1001001",
          violationType: "逾期未还",
          violationDate: "2025-04-30",
          fineAmount: 5,
          status: "已处理",
          remarks: "已缴纳罚款"
        },
        {
          bookName: "深入理解计算机系统",
          bookId: "1001002",
          violationType: "图书损坏",
          violationDate: "2025-04-30",
          fineAmount: 10,
          status: "未处理",
          remarks: "需赔偿图书"
        }
      ]
};
