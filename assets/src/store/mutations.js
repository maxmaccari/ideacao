import Vue from 'vue'

export default {
  authenticate(state, {user, authToken}) {
    state.user = user
    state.authToken = authToken
  },
  logout(state) {
    state.user = null
    state.authToken = null
    state.ideas = []
  },
  setIdeas(state, ideas) {
    state.ideas = ideas;
  },
  addIdea(state, idea) {
    const found = state.ideas.find(i => i.id == idea.id)
    if (!found) state.ideas.push(idea)
  },
  setFeedbacks(state, {idea_id, feedbacks}) {
    const idea = state.ideas.find(idea => idea.id == idea_id)
    Vue.set(idea, 'feedbacks', feedbacks)
  },
  addFeedback(state, {idea_id, feedback}) {
    const idea = state.ideas.find(idea => idea.id == idea_id)
    const found = idea.feedbacks.find(f => f.id == feedback.id)
    if (!found) idea.feedbacks.push(feedback)
  },
  setError(state, payload) {
    state.error = payload
  },
  clearError(state) {
    state.error = null
  },
  setSocket(state, socket) {
    state.socket = socket
  }
}