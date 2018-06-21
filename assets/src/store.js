import Vuex from 'vuex';
import Vue from 'vue';

import createPersistedState from "vuex-persistedstate";

Vue.use(Vuex);

const dummyUsers = [
  {
    id: 1,
    email: 'maxmaccari@hotmail.com',
    name: 'Maxsuel'
  },
  {
    id: 2,
    email: 'mateus@gmail.com',
    name: 'Mateus'
  },
  {
    id: 3,
    email: 'annajulialves75@gmail.com',
    name: 'Anna Júlia'
  }
]

const store = new Vuex.Store({
  plugins: [createPersistedState()],
  state: {
    ideas: [],
    user: null,
    authToken: null,
    error: null
  },
  getters: {
    loggedIn: state => !!state.user && !!state.authToken,
    hasError: state => !!state.error
  },
  mutations: {
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
  },
  actions: {
    register({commit}, user){
      const authToken = 'test'
      commit('authenticate', {
        user,
        authToken
      })
    },
    login({commit}, credentials) {
      const user = dummyUsers.find(user => user.email == credentials.email)
      if(user) {
        const authToken = 'test'
        commit('clearError')
        commit('authenticate', {
          user,
          authToken
        })
      } else {
        commit('setError', {
          origin: 'login',
          message: 'Email ou senha inválido.'
        })
      }
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
})

export default store;