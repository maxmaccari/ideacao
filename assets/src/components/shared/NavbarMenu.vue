<template>
  <div>
    <nav>
      <div class="nav-wrapper container">
        <a href="#/" class="brand-logo center">Ideação</a>
        <a href="#" data-target="mobile-menu" class="sidenav-trigger"><i class="material-icons">menu</i></a>
        <ul id="menu" class="right hide-on-med-and-down">
          <li v-if="user">
            <a href="#">
              <i class="material-icons left">account_circle</i>{{user.name}}
            </a>
          </li>
          <li v-for="(item, index) in items" :key="index">
            <a v-if="item.href" :href="item.href">{{item.title}}</a>
            <a v-else-if="item.event" href="#" @click.prevent="sidenav.close(); $emit(item.event)"/>
            <a v-else-if="item.action" href="#" @click.prevent="sidenav.close(); item.action()">{{item.title}}</a>
          </li>
        </ul>
      </div>
    </nav>

    <ul id="mobile-menu" class="sidenav">
      <li v-if="user">
        <div class="user-view">
          <a href="#"><span class="name black-text">{{user.name}}</span></a>
        </div>
      </li>
      <li v-if="user"><div class="divider"/></li>
      <li v-for="(item, index) in items" :key="index">
        <a v-if="item.href" :href="item.href">{{item.title}}</a>
        <a v-else-if="item.event" href="#" @click.prevent="sidenav.close(); $emit(item.event)"/>
        <a v-else-if="item.action" href="#" @click.prevent="sidenav.close(); item.action()">{{item.title}}</a>
      </li>
    </ul>
  </div>
</template>

<script>
import M from 'materialize-css'

import { mapState, mapActions } from 'vuex'

export default {
  data () {
    return {
      items: [
        {title: "Sair", action: this.logout}
      ],
      sidenav: null
    }
  },
  computed: mapState(['user']),
  mounted () {
    const elems = document.querySelectorAll('.sidenav');
    const sidenavs = M.Sidenav.init(elems);
    this.sidenav = sidenavs[0]
  },
  methods: mapActions(['logout'])
}
</script>

<style>

</style>
