import axios from 'axios'
import config from '../../config'
import authToken from './authToken'

const Http = axios.create({
  baseURL: config.API_URL,
  timeout: 1000,
  headers: {
    'Accept': 'application/json',
    'Content-Type': 'application/json'
  }
})

Http.interceptors.request.use((config) => {
  const token = authToken()

  if (token) {
    config.headers['Authorization'] = `Bearer ${token}`
  }

  return config
})

export default Http