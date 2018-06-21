<template>
  <div class="container">
    <ideas-list :ideas="ideas" :user="user"/>

    <new-idea-modal v-if="showModal" @close="showModal = false" @add="addIdea"/>
    <div class="fixed-action-btn">
      <a class="btn-floating btn-large waves-effect waves-light red"
         @click.prevent="showModal = true">
        <i class="material-icons">add</i>
      </a>
    </div>
  </div>
</template>

<script>
import IdeasList from '@/components/ideas/IdeasList'
import NewIdeaModal from '@/components/ideas/NewIdeaModal'

import { mapActions, mapState } from 'vuex'

export default {
  components: {
    IdeasList,
    NewIdeaModal
  },
  data () {
    return {
      showModal: false
    }
  },
  computed: mapState(['ideas', 'user']),
  methods: mapActions(['addIdea'])
}
</script>

<style>
</style>
