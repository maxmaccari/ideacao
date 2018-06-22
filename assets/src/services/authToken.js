import store from '@/store'

export default function() {
  if (store) {
    if (store.state.authToken) {
      return store.state.authToken;
    }
  }

  return null;
}