import Http from './http'

export default {
  all() {
    return Http.get('/ideas').then(response => response.data)
  },
  create(idea) {
    return Http.post('/ideas', {idea: idea})
               .then(response => response.data)
  },
  allFeedbacks(idea_id) {
    return Http.get(`/ideas/${idea_id}/feedbacks`)
               .then(response => response.data)
  }
}