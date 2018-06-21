export default {
  loggedIn: state => !!state.user && !!state.authToken,
  hasError: state => !!state.error
}