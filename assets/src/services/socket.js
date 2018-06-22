import { Socket } from 'phoenix'
import config from '../../config'

let socket = null

const createSocket = (token) => {
  socket = new Socket(config.SOCKET_URL, { params: {token: token} })
  socket.connect()

  return socket;
}

export {
  createSocket
}