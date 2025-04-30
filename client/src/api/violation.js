
import request from '@/utils/request'

export function getViolationRecords(userId) {
  return request({
    url: '/violation/records',
    method: 'get',
    params: { userId }
  })
}
