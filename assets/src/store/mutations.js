export default {
  authenticate(state, {user, authToken}) {
    state.user = user
    state.authToken = authToken
  },
  logout(state) {
    state.user = null
    state.authToken = null
  },
  addIdea(state, idea) {
    state.ideas.push(idea)
  },
  addFeedback(state, {idea_id, feedback}) {
    const idea = state.ideas.find(idea => idea.id == idea_id)
    idea.feedbacks.push(feedback)
  },
  setError(state, payload) {
    state.error = payload
  },
  clearError(state) {
    state.error = null
  }
}