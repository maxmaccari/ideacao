<template>
  <div id="registerModal" class="modal">
    <div class="modal-content">
      <h4>Cadastro</h4>
      <form action="#" @submit.prevent="register">
        <div class="input-field">
          <input id="name" v-model="user.name" type="text" name="name" required>
          <label for="name">Nome</label>
        </div>

        <div class="input-field">
          <input v-model="user.email" type="email" name="email" required>
          <label for="email">Email</label>
        </div>

        <div class="input-field">
          <input v-model="user.password" type="password" name="password" required>
          <label for="password">Senha</label>
        </div>

        <div class="input-field">
          <input v-model="user.passwordConfirmation" type="password" name="password_confirmation" required>
          <label for="password_confirmation">Confirme a sua Senha</label>
        </div>


        <button class="btn">Confirmar</button>
      </form>
    </div>
  </div>
</template>

<script>
import M from 'materialize-css'

export default {
  data () {
    return {
      modal: null,
      user: {
        name: "",
        email: "",
        password: "",
        passwordConfirmation: ""
      }
    }
  },
  mounted () {
    const vm = this
    const elem = document.getElementById("registerModal")
    const modal = M.Modal.init(elem, {
      onCloseEnd() {
        vm.$emit('close')
      }
    })

    this.modal = modal;

    modal.open()
  },
  methods: {
    register () {
      this.$emit('register', this.user)
      this.modal.close()
    }
  },
}
</script>

<style>

</style>
