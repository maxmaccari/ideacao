<template>
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
      <a class="btn-flat waves-effect waves-red" @click.prevent="modal.close()">Cancelar</a>
      <a :class="{disabled: !isNewIdeaValid}" class="btn-flat waves-effect waves-green" @click.prevent="addIdea">Adicionar <i class="material-icons right">send</i></a>
    </div>
  </div>
</template>

<script>
import M from 'materialize-css'

export default {
  data () {
    return {
      newIdea : {
        title: "",
        problem: "",
        description: "",
        feedbacks: [],
        author: {
          id: 1,
          name: "Maxsuel"
        }
      },
      modal: null
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
    const vm = this
    const elem = document.getElementById("newIdeaModal")
    const modal = M.Modal.init(elem, {
          onCloseEnd () {
            vm.$emit('close')
          }
        })

    this.modal = modal;

    modal.open()
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
