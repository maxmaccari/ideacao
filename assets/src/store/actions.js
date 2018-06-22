import Vue from 'vue'
import { Ideas, Users } from '../services'
import { createSocket } from '../services/socket'
import { listenIdeas }  from '../listeners'

export default {
  register({commit, dispatch}, user){
    Users.register(user)
      .then(data => {
        const authToken = data.token
        const user = data.user

        commit('clearError')
        commit('authenticate', { user, authToken })
        dispatch('connectSocket')
      })
      // TODO Implement errors for registration
      // .catch(error => {
      //   commit('setError', {
      //     origin: 'register',
      //     message: error.response.data.errors
      //   })
      // })

  },
  login({commit, dispatch}, credentials) {
    Users.login(credentials)
      .then(data => {
        const authToken = data.token
        const user = data.user

        commit('clearError')
        commit('authenticate', {user, authToken})
        dispatch('connectSocket')
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
  loadIdeas({commit, dispatch}) {
    Ideas.all()
      .then(data => {
        commit('setIdeas', data.ideas)

        data.ideas.forEach(idea => dispatch('loadFeedbacks', idea))
      })
  },
  addIdea({commit}, idea) {
    Ideas.create(idea)
      .then(data => {
        Vue.set(data.idea, 'feedbacks', [])
        commit('addIdea', data.idea)
      })
  },
  loadFeedbacks({commit}, idea) {
    Ideas.allFeedbacks(idea.id)
      .then(data => {
        commit('setFeedbacks', {
          idea_id: idea.id,
          feedbacks: data.feedbacks
        })
      })
  },
  addFeedback({commit}, {idea, feedback}) {
    Ideas.createFeedback(idea.id, feedback)
      .then(data => {
        commit('addFeedback', {
          idea_id: idea.id,
          feedback: data.feedback
        })
      })
  },
  connectSocket(context) {
    if (context.state.authToken == null) return null
    const socket = createSocket(context.state.authToken)
    listenIdeas(socket, context)
  }
}