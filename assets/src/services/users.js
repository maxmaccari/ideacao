import Http from './http';

export default {
  login (credentials) {
    return Http.post('/users/sign_in', {
      user: credentials
    }).then(response => response.data);
  },
  register (user) {
    return Http.post('/users', { user })
      .then(response => response.data);
  }
}