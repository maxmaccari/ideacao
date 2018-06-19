<template>
  <div class="container">
    <div class="row">
      <div class="col s12 m5 offset-m4">
        <div class="card">
          <div class="card-content">
            <span class="card-title">Login</span>
            <form action="#">
              <div class="input-field">
                <input id="email" type="email" name="email" required>
                <label for="email">Email</label>
              </div>

              <div class="input-field">
                <input id="password" type="password" name="password" required>
                <label for="password">Senha</label>
              </div>

              <button class="btn" @click.prevent="loginUser">Login</button>
            </form>
          </div>
          <div class="card-action">
            <a href="#" @click.prevent="newUserModal.open()">Me Cadastrar</a>
          </div>
        </div>
      </div>
    </div>
    <div id="newUserModal" class="modal">
      <div class="modal-content">
        <h4>Cadastro</h4>
        <form action="#">
          <div class="input-field">
            <input id="name" type="text" name="name" v-model="newUser.name" required>
            <label for="name">Nome</label>
          </div>

          <div class="input-field">
            <input type="email" name="email" v-model="newUser.email" required>
            <label for="email">Email</label>
          </div>

          <div class="input-field">
            <input type="password" name="password" v-model="newUser.password" required>
            <label for="password">Senha</label>
          </div>

          <div class="input-field">
            <input type="password" name="password_confirmation" v-model="newUser.passwordConfirmation" required>
            <label for="password_confirmation">Confirme a sua Senha</label>
          </div>


          <button class="btn" @click.prevent="registerUser">Confirmar</button>
        </form>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      newUserModal: null,
      newUser: {
        name: "",
        email: "",
        password: "",
        passwordConfirmation: ""
      }
    }
  },
  methods: {
    loginUser () {
      this.$emit('login', {
        id: 1,
        name: "Maxsuel"
      })
    },
    registerUser () {
      this.newUserModal.close()
      this.$emit('login', this.newUser)
    }
  },
  mounted() {
    const vm = this
    const elem = document.getElementById("newUserModal")
    const modal = M.Modal.init(elem)

    this.newUserModal = modal;
  }
}
</script>

<style>

</style>
