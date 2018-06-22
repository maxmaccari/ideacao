import Vue from 'vue'
import { Users } from '../services'

export default {
  register({commit}, user){
    Users.register(user)
      .then(data => {
        const authToken = data.token
        const user = data.user

        commit('clearError')
        commit('authenticate', { user, authToken })
      })
      // TODO Implement errors for registration
      // .catch(error => {
      //   commit('setError', {
      //     origin: 'register',
      //     message: error.response.data.errors
      //   })
      // })

  },
  login({commit}, credentials) {
    Users.login(credentials)
      .then(data => {
        const authToken = data.token
        const user = data.user

        commit('clearError')
        commit('authenticate', {user, authToken})
      })
      .catch(() => {
        // TODO Enhance errors handling and localize erros in backend
        commit('setError', {
          origin: 'login',
          message: 'Email ou senha inválida.'
        })
      })
  },
  logout({commit}) {
    commit('logout')
  },
  addIdea({commit, state}, idea) {
    idea.id = state.ideas.length + 1
    idea.author = state.user
    Vue.set(idea, 'feedbacks', [])
    commit('addIdea', idea)
  },
  addFeedback({commit, state}, {idea, feedback}) {
    feedback.user = state.user
    feedback.id = idea.id + idea.feedbacks.length + 1
    commit('addFeedback', {
      idea_id: idea.id,
      feedback: feedback
    })
  }
}