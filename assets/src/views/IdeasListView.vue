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

export default {
  components: {
    IdeasList,
    NewIdeaModal
  },
  props: {
    ideas: {
      type: Array,
      required: true
    },
    user: {
      type: Object,
      required: true
    }
  },
  data () {
    return {
      showModal: false
    }
  },
  methods: {
    addIdea(idea) {
      this.ideas.push(idea)
    }
  }
}
</script>

<style>
</style>
