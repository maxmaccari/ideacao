import Vuex from 'vuex';
import Vue from 'vue';

Vue.use(Vuex);

const dummyIdeas = [
  {
    id: 0,
    title: "Projeto Ideação",
    problem:
      "Colaboração de equipes no processo de validação de ideias e inovação",
    description:
      "Plataforma online para facilitar a colaboração de equipes no projeto",
    feedbacks: [
      {
        id: 1,
        rating: 8.5,
        comment: "Lorem ipsum dolor sit amet consectetur adipisicing elit. Excepturi beatae minus iusto repudiandae recusandae, ullam, officiis odit totam expedita quas facere rerum alias accusantium natus!",
        user: { name: "Maxsuel", id: 1 }
      },
      {
        id: 2,
        rating: 6,
        comment: "Lorem ipsum dolor sit amet consectetur adipisicing elit. Excepturi beatae minus iusto repudiandae recusandae, ullam, officiis odit totam expedita quas facere rerum alias accusantium natus!",
        user: { name: "Mateus", id: 2 }
      }
    ],
    author: {
      id: 1,
      name: "Maxsuel Maccari"
    }
  },
  {
    id: 1,
    title: "Projeto MyShopping",
    problem:
      "Lista de compras em supermercado em tempo real para casais e famílias",
    description:
      "Um aplicativo que fornece as funcionalidades necessárias para a lista",
    feedbacks: [],
    author: {
      id: 1,
      name: "Maxsuel Maccari"
    }
  },
  {
    id: 2,
    title: "Alugga",
    problem: "Gestão de imóveis",
    description: "Plataforma online para facilitar a gestão de imóveis",
    feedbacks: [
      {
        id: 3,
        rating: 9.5,
        comment: "Lorem ipsum dolor sit amet consectetur adipisicing elit. Excepturi beatae minus iusto repudiandae recusandae, ullam, officiis odit totam expedita quas facere rerum alias accusantium natus!",
        user: { name: "Mateus", id: 2 }
      }
    ],
    author: {
      id: 1,
      name: "Maxsuel Maccari"
    }
  },
  {
    id: 3,
    title: "AcompanheAki",
    problem: "Falta de acompanhamento dos pais na vida escolar dos filhos",
    description:
      "Plataforma online para fomentar o acompanhamento dos pais na vida dos alunos",
    feedbacks: [],
    author: {
      id: 3,
      name: "Maurício Maccari"
    }
  }
];

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
  state: {
    ideas: dummyIdeas,
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
      idea.author = state.user
      idea.feedbacks = []
      idea.id = state.ideas.length + 1
      commit('addIdea', idea)
    },
    addFeedback({commit, state}, {idea, feedback}) {
      feedback.user = state.user
      commit('addFeedback', {
        idea_id: idea.id,
        feedback: feedback
      })
    }
  }
})


export default store;