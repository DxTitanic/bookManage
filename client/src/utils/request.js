import axios from 'axios'
import router from "../router";
import { mockData } from '../api/violation';

const request = axios.create({
    baseURL: '/api',
    timeout: 5000
})

// request 拦截器
// 可以自请求发送前对请求做一些处理
// 比如统一加token，对请求参数统一加密
request.interceptors.request.use(config => {
    config.headers['Content-Type'] = 'application/json;charset=utf-8';

    // config.headers['token'] = user.token;  // 设置请求头
    // 取出sessionStorage里面缓存的用户信息
    let userJson = sessionStorage.getItem("user")
    if(!userJson)
        {
            router.push("/login")
        }
    return config
}, error => {
    return Promise.reject(error)
});

// response 拦截器
// 可以在接口响应后统一处理结果
request.interceptors.response.use(
    response => {
        let res = response.data;
        // 如果是返回的文件
        if (response.config.responseType === 'blob') {
            return res
        }
        // 兼容服务端返回的字符串数据
        if (typeof res === 'string') {
            res = res ? JSON.parse(res) : res
        }
        return res;
    },
    error => {
        console.log('err' + error) // for debug
        return Promise.reject(error)
    }
)

// 添加具体请求方法
export function fetchViolationRecords(params) {
    // 开发环境下使用mock数据
    if (process.env.NODE_ENV === 'development') {
        return Promise.resolve({
            data: mockData.violationData, // 返回正确的数据结构
            status: 200,
            statusText: 'OK'
        });
    }
    
    return request({
        url: '/violation/records',
        method: 'get',
        params
    })
}

export default request

