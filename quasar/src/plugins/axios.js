import axios from 'axios'

export default ({ Vue }) => {
  Vue.prototype.$axios = axios
}

export function register ({commit}, form) {
  return axios.post('api/auth/register', form)
      .then(response => {
        commit('login', {token: response.data.token, user: response.data.user})
        setAxiosHeaders(response.data.token)
      })
}

function setAxiosHeaders (token) {
  axios.defaults.headers.common['Authorization'] = 'Bearer ' + token
}