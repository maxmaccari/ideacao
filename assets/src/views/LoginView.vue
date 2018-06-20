<template>
  <div class="container">
    <div class="row">
      <div class="col s12 m8 offset-m2 l6 offset-l3 xl6 offset-xl3">
        <div id="loginPanel" class="card">
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
            <a href="#" @click.prevent="openModal = true">Me Cadastrar</a>
          </div>
        </div>
      </div>
    </div>
    <register-user-modal v-if="openModal" @close="openModal=false" @register="registerUser"/>
  </div>
</template>

<script>
import RegisterUserModal from "@/components/login/RegisterUserModal"

export default {
  components: {
    RegisterUserModal
  },
  data() {
    return {
      openModal: false
    }
  },
  methods: {
    loginUser () {
      this.$emit('login', {
        id: 1,
        name: "Maxsuel"
      })
    },
    registerUser (user) {
      this.$emit('login', user)
    }
  }
}
</script>

<style>
   #loginPanel {
      margin-top: 120px;
    }

  @media only screen and (min-width: 600px) {
    #loginPanel {
      margin-top: 150px;
    }
  }
</style>
