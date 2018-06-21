<template>
  <div class="container">
    <div class="row">
      <div class="col s12 m8 offset-m2 l6 offset-l3 xl6 offset-xl3">
        <div id="loginPanel" class="card">
          <div class="card-content">
            <span class="card-title">Login</span>

            <div v-if="hasError" class="error red-text lighten-1">
              {{error.message}}
            </div>

            <form action="#" @submit.prevent="loginUser">
              <div class="input-field">
                <input id="email" v-model="credentials.email" type="email" name="email" required>
                <label for="email">Email</label>
              </div>

              <div class="input-field">
                <input id="password" v-model="credentials.password" type="password" name="password" required>
                <label for="password">Senha</label>
              </div>

              <button :disabled="!canLogin" class="btn">Login</button>
            </form>
          </div>
          <div class="card-action">
            <a href="#" @click.prevent="openModal = true">Me Cadastrar</a>
          </div>
        </div>
      </div>
    </div>
    <register-user-modal v-if="openModal" @close="openModal=false" @register="register"/>
  </div>
</template>

<script>
import RegisterUserModal from "@/components/login/RegisterUserModal"

import { mapActions, mapGetters, mapState } from 'vuex';

export default {
  components: {
    RegisterUserModal
  },
  data() {
    return {
      openModal: false,
      credentials: {
        email: "",
        password: ""
      }
    }
  },
  computed: {
    canLogin () {
      return this.credentials.email.length >= 3 &&
             this.credentials.password.length >= 5
    },
    ...mapGetters(['hasError']),
    ...mapState(['error'])
  },
  methods: {
    loginUser() {
      this.login(this.credentials)
    },
    ...mapActions(['login', 'register'])
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
