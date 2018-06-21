<template>
  <div :id="modalName" class="modal">
    <div class="modal-content">
      <h4>Cadastro</h4>
      <form action="#" @submit.prevent="register">
        <div class="input-field">
          <input id="name" v-model="user.name" type="text" name="name" required>
          <label for="name">Qual é o seu nome?</label>
        </div>

        <div class="input-field">
          <input v-model="user.email" type="email" name="email" required>
          <label for="email">E o qual é o seu email?</label>
        </div>

        <div class="input-field">
          <input v-model="user.password" type="password" name="password" required>
          <label for="password">Insira a sua senha</label>
        </div>

        <div class="input-field">
          <input v-model="user.passwordConfirmation" type="password" name="password_confirmation" required>
          <label for="password_confirmation">Confirme a sua senha</label>
        </div>

        <p v-if="user.passwordConfirmation.length > 0 && !passwordValid"
           class="red-text">As senhas são não se correspondem</p>


        <button :disabled="!isValid" class="btn">Confirmar</button>
      </form>
    </div>
  </div>
</template>

<script>
import modalMixin from '@/components/mixins/modalMixin'

export default {
  mixins: [modalMixin],
  data () {
    return {
      modalName: 'registerModal',
      user: {
        name: "",
        email: "",
        password: "",
        passwordConfirmation: ""
      }
    }
  },
  computed: {
    isValid () {
      return this.user.name.length > 0 &&
             this.user.email.length > 0 &&
             this.user.password.length >= 3 &&
             this.passwordValid
    },
    passwordValid () {
      return this.user.passwordConfirmation == this.user.password
    }
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
