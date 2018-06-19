<template>
  <div id="app">
    <div v-if="loggedInUser" class="container">
      <div v-for="idea in ideas" :key="idea.id" class="section">
        <h4>{{idea.title}}</h4>
        <h5>Problema: </h5>
        <p>{{idea.problem}}</p>
        <h5>Descrição: </h5>
        <p>{{idea.description}}</p>
        <p class="right-align feedbacks">{{idea.feedbacks.count}} feedbacks até o momento
          <span v-if="idea.feedbacks.count > 0"> com a nota {{idea.feedbacks.rating}} por:
            <a v-for="user in idea.feedbacks.users" :key="user.id" href="#" @click.prevent="showFeedbacksModal.open()">
              [{{user.name}}]
            </a>
          </span>
          <a v-if="canGiveFeedback(idea)" href="#" @click.prevent="newFeedbackModal.open()">Dar Feedback</a>
        </p>
        <div class="divider"/>
      </div>

      <div id="newIdeaModal" class="modal">
        <div class="modal-content">
          <h4>Nova Ideia</h4>
          <form>
            <div class="input-field">
              <input id="title" v-model="newIdea.title" type="text" name="title" required>
              <label for="title">Título</label>
            </div>
            <div class="input-field">
              <textarea id="problem" v-model="newIdea.problem" name="problem" class="materialize-textarea" required/>
              <label for="problem">Problema</label>
            </div>
            <div class="input-field">
              <textarea id="description" v-model="newIdea.description" name="description" class="materialize-textarea" required/>
              <label for="description">Descrição</label>
            </div>
          </form>
        </div>
        <div class="modal-footer">
          <a class="btn-flat waves-effect waves-red" @click.prevent="newIdeaModal.close()">Cancelar</a>
          <a :class="{disabled: !isNewIdeaValid}" class="btn-flat waves-effect waves-green" @click.prevent="addIdea">Adicionar <i class="material-icons right">send</i></a>
        </div>
      </div>

      <div class="fixed-action-btn">
        <a class="btn-floating btn-large waves-effect waves-light red" @click.prevent="newIdeaModal.open()"><i class="material-icons">add</i></a>
      </div>

      <div id="newFeedbackModal" class="modal">
        <div class="modal-content">
          <h4>Novo Feedback na ideia #ideia</h4>
        </div>
      </div>

      <div id="showFeedbacksModal" class="modal">
        <div class="modal-content">
          <h4>Feedbacks de ideias de Maxsuel</h4>
          <p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Laborum adipisci aut quia rem porro? Optio similique dolorem aspernatur praesentium, quod consectetur minima nobis sint possimus! Nesciunt asperiores recusandae numquam dolorem vitae. Ipsam iste fugit adipisci minus est hic tempora molestias?</p>
        </div>
        <div class="modal-footer">
          <a class="btn-flat waves-effect waves-red" @click.prevent="showFeedbacksModal.close()">Fechar</a>
        </div>
      </div>
    </div>
    <login-view v-else @login="loginUser"></login-view>
  </div>
</template>

<script>
import M from 'materialize-css'
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
    LoginView
  },
  data () {
    return {
      ideas: ideas,
      newIdea : {
        title: "",
        problem: "",
        description: "",
        feedbacks: {count: 0, rating: 0, users: []}
      },
      // currentUser: {
      //   id: 1,
      //   name: "Maxsuel"
      // },
      currentUser: null,
      newIdeaModal: null,
      newFeedbackModal: null,
      showFeedbacksModal: null
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
  mounted () {
    // this.loginUser()

    ["newIdeaModal", "newFeedbackModal", "showFeedbacksModal"]
      .forEach( name => {
        const vm = this
        const elem = document.getElementById(name)
        const modal = M.Modal.init(elem, {
          onCloseStart () {
            vm.resetNewIdea()
            M.updateTextFields();
          }
        });

        this[name] = modal;
      })
  },
  methods: {
    addIdea() {
      if (this.isNewIdeaValid) {
        this.ideas.push(this.newIdea)
        this.resetNewIdea()
        this.newIdeaModal.close()
      }
    },
    resetNewIdea () {
      this.newIdea = {
        title: "",
        problem: "",
        description: "",
        feedbacks: {count: 0, rating: 0, users: []}
      }
    },
    canGiveFeedback (idea) {
      return !idea.feedbacks.users.some(user => user.id == this.currentUser.id);
    },
    loginUser (user) {
      this.currentUser = user
    }
  },
}
</script>

<style>
  .feedbacks {
    font-size: 12px;
    color: gray;
  }
</style>
