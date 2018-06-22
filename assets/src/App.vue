<template>
  <div id="app">
    <navbar-menu v-if="loggedIn"/>
    <ideas-list-view v-if="loggedIn" class="main"/>
    <login-view  v-else class="main"/>
    <app-footer/>
  </div>
</template>

<script>
import AppFooter from "@/components/shared/AppFooter";
import IdeasListView from "@/views/IdeasListView";
import LoginView from "@/views/LoginView";
import NavbarMenu from "@/components/shared/NavbarMenu";

import { mapActions, mapGetters } from "vuex";

export default {
  name: "app",
  components: {
    AppFooter,
    IdeasListView,
    LoginView,
    NavbarMenu
  },
  computed: mapGetters(["loggedIn"]),
  mounted () {
    this.connectSocket()
  },
  methods: mapActions(["logout", "connectSocket"])
};
</script>

<style>
body,
#app {
  display: flex;
  min-height: 100vh;
  flex-direction: column;
}

div.main {
  flex: 1 0 auto;
}
</style>
