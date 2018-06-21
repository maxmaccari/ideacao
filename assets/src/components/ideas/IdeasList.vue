<template>
  <div>
    <div v-for="idea in ideas" :key="idea.id" class="section">
      <h4>{{idea.title}}</h4>
      Autoria de: <i>{{idea.author.name}}</i>
      <h5>Qual é o Público Alvo dessa ideia?</h5>
      <p>{{idea.target}}</p>
      <h5>Qual problema essa ideia ataca?</h5>
      <p>{{idea.problem}}</p>
      <h5>Como essa ideia busca resolver o problema?</h5>
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
