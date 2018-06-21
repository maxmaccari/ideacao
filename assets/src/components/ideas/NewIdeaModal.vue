<template>
  <div :id="modalName" class="modal">
    <div class="modal-content">
      <h4>Nova Ideia</h4>
      <form>
        <div class="input-field">
          <input id="title" v-model="newIdea.title" type="text" name="title" required>
          <label for="title">Qual título quer dar para a sua ideia?</label>
        </div>
        <div class="input-field">
          <textarea id="target" v-model="newIdea.target" class="materialize-textarea" name="target" required/>
          <label for="target">Qual é o Público Alvo sua ideia?</label>
        </div>
        <div class="input-field">
          <textarea id="problem" v-model="newIdea.problem" name="problem" class="materialize-textarea" required/>
          <label for="problem">Que problema sua ideia busca atacar?</label>
        </div>
        <div class="input-field">
          <textarea id="description" v-model="newIdea.description" name="description" class="materialize-textarea" required/>
          <label for="description">Como sua ideia busca resolver esse problema?</label>
        </div>
      </form>
    </div>
    <div class="modal-footer">
      <a class="btn-flat waves-effect waves-red" @click.prevent="modal.close()">Cancelar</a>
      <a :class="{disabled: !isNewIdeaValid}" class="btn-flat waves-effect waves-green" @click.prevent="addIdea">Adicionar <i class="material-icons right">send</i></a>
    </div>
  </div>
</template>

<script>
import modalMixin from '@/components/mixins/modalMixin'

export default {
  mixins: [modalMixin],
  data () {
    return {
      newIdea : {
        title: "",
        target: "",
        problem: "",
        description: ""
      },
      modalName: "newIdeaModal"
    }
  },
  computed: {
    isNewIdeaValid () {
      return this.newIdea.title.length > 0 &&
             this.newIdea.target.length > 0 &&
             this.newIdea.problem.length > 0 &&
             this.newIdea.description.length > 0
    }
  },
  methods: {
    addIdea() {
      if (this.isNewIdeaValid) {
        this.$emit('add', this.newIdea)

        this.modal.close()
      }
    }
  },
}
</script>

<style>

</style>
