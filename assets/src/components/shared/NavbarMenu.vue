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
            <a v-else href="#" @click.prevent="$emit(item.action)">{{item.title}}</a>
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
        <a v-else href="#" @click.prevent="sidenav.close(); $emit(item.action)">{{item.title}}</a>
      </li>
    </ul>
  </div>
</template>

<script>
import M from 'materialize-css'

export default {
  props: {
    user: {
      type: Object,
      default: null
    }
  },
  data () {
    return {
      items: [
        {title: "Sair", action: "logout"}
      ],
      sidenav: null
    }
  },
  mounted () {
    const elems = document.querySelectorAll('.sidenav');
    const sidenavs = M.Sidenav.init(elems);
    this.sidenav = sidenavs[0]
  }
}
</script>

<style>

</style>
