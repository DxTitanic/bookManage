
const state = {
  announcements: JSON.parse(localStorage.getItem('announcements') || '[]'),
  isAdmin: false
}

const mutations = {
  SET_ANNOUNCEMENTS(state, payload) {
    state.announcements = payload
    localStorage.setItem('announcements', JSON.stringify(payload))
  },
  ADD_ANNOUNCEMENT(state, payload) {
    console.log('添加公告前:', state.announcements)
    state.announcements.unshift(payload)
    console.log('添加公告后:', state.announcements)
    localStorage.setItem('announcements', JSON.stringify(state.announcements))
    console.log('localStorage存储内容:', localStorage.getItem('announcements'))
  },
  SET_ADMIN(state, isAdmin) {
    state.isAdmin = isAdmin
  }
}

const actions = {
  fetchAnnouncements({ commit, state }) {
    // 优先读取缓存数据
    if (state.announcements.length > 0) {
      return
    }
    // 没有缓存时使用mock数据
    const mockData = [
      { id: 1, title: '系统维护通知', content: '系统将于今晚进行维护', date: '2025-04-12' },
      { id: 2, title: '假期安排', content: '五一假期图书馆开放时间调整', date: '2025-04-28' }
    ]
    commit('SET_ANNOUNCEMENTS', mockData)
  },
  addAnnouncement({ commit, state }, announcement) {
    if (!state.isAdmin) {
      throw new Error('无权限添加公告')
    }
    // 实际项目中这里调用API
    const newAnnouncement = {
      ...announcement,
      id: Date.now(),
      date: new Date().toISOString().split('T')[0]
    }
    commit('ADD_ANNOUNCEMENT', newAnnouncement)
    return Promise.resolve(newAnnouncement)
  }
}

export default {
  namespaced: true,
  state,
  mutations,
  actions
}
