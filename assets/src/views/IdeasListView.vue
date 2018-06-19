<template>
  <div class="container">
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
</template>

<script>
export default {
  props: {
    ideas: {
      type: Array,
      required: true
    },
    user: {
      type: Object,
      required: true
    }
  },
  data () {
    return {
      newIdea : {
        title: "",
        problem: "",
        description: "",
        feedbacks: {count: 0, rating: 0, users: []}
      },
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
    }
  },
  mounted () {
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
      return !idea.feedbacks.users.some(user => user.id == this.user.id);
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
