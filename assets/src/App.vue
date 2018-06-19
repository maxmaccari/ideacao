<template>
  <div id="app">
    <ideas-list-view v-if="loggedInUser" :ideas="ideas" :user="currentUser"></ideas-list-view>
    <login-view v-else @login="loginUser"></login-view>
  </div>
</template>

<script>
import M from 'materialize-css'
import IdeasListView from '@/views/IdeasListView'
import LoginView from '@/views/LoginView'

const ideas = [
  {
    id: 0,
    title: "Projeto Ideação",
    problem: "Colaboração de equipes no processo de validação de ideias e inovação",
    description: "Plataforma online para facilitar a colaboração de equipes no projeto",
    feedbacks: {
      count: 2,
      rating: 8.3,
      users: [{name: "Maxsuel", id: 1}, {name: "Mateus", id: 2}]
    }
  },
  {
    id: 1,
    title: "Projeto MyShopping",
    problem: "Lista de compras em supermercado em tempo real para casais e famílias",
    description: "Um aplicativo que fornece as funcionalidades necessárias para a lista",
    feedbacks: {
      count: 0,
      rating: 0,
      users: []
    }
  },
  {
    id: 2,
    title: "Alugga",
    problem: "Gestão de imóveis",
    description: "Plataforma online para facilitar a gestão de imóveis",
    feedbacks: {
      count: 1,
      rating: 9.0,
      users: [{name: "Maxsuel", id: 1}]
    }
  },
  {
    id: 3,
    title: "AcompanheAki",
    problem: "Falta de acompanhamento dos pais na vida escolar dos filhos",
    description: "Plataforma online para fomentar o acompanhamento dos pais na vida dos alunos",
    feedbacks: {
      count: 0,
      rating: 0,
      users: []
    }
  }
]

export default {
  name: 'app',
  components: {
    LoginView,
    IdeasListView
  },
  data () {
    return {
      ideas: ideas,
      currentUser: null
    }
  },
  computed: {
    isNewIdeaValid () {
      return this.newIdea.title.length > 0 &&
             this.newIdea.problem.length > 0 &&
             this.newIdea.description.length > 0
    },
    loggedInUser () {
      return !!this.currentUser
    }
  },
  methods: {
    loginUser (user) {
      this.currentUser = user
    }
  },
}
</script>

<style>
</style>
