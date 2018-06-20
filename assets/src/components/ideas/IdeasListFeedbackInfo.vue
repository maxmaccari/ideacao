<template>
  <p class="right-align feedbacks">
    {{idea.feedbacks.count}} feedbacks até o momento
    <span v-if="idea.feedbacks.count > 0"> com a nota {{idea.feedbacks.rating}} por:
      <a v-for="user in idea.feedbacks.users" :key="user.id" href="#" @click.prevent="showFeedbacksModal.open()">
        [{{user.name}}]
      </a>
    </span>
    <a v-if="canGiveFeedback(idea)" href="#" @click.prevent="newFeedbackModal.open()">Dar Feedback</a>
  </p>
</template>

<script>
export default {
  props: {
    idea: {
      type: Object,
      required: true
    },
    user: {
      type: Object,
      required: true
    }
  },
  methods: {
    canGiveFeedback (idea) {
      return !idea.feedbacks.users.some(user => user.id == this.user.id);
    }
  }
}
</script>

<style scoped>
  p.feedbacks {
    font-size: 12px;
    color: gray;
  }
</style>
