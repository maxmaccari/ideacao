<template>
  <div>
    <div v-for="idea in ideas" :key="idea.id" class="section">
      <h4>{{idea.title}}</h4>
      <h5>Problema: </h5>
      <p>{{idea.problem}}</p>
      <h5>Descrição: </h5>
      <p>{{idea.description}}</p>
      <feedbacks-info :idea="idea" :user="user"/>
      <div class="divider"/>
    </div>
  </div>
</template>

<script>
import IdeasListFeedbacksInfo from '@/components/ideas/IdeasListFeedbackInfo'

export default {
  components: {
    feedbacksInfo: IdeasListFeedbacksInfo
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
  }
}
</script>

<style>

</style>
