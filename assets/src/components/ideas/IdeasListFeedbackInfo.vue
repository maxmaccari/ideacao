<template>
  <p class="right-align">
    <span class="feedbacks">
      {{idea.feedbacks.count}} feedbacks até o momento
      <span v-if="idea.feedbacks.count > 0"> com a nota {{idea.feedbacks.rating}} por:
        <a v-for="user in idea.feedbacks.users" :key="user.id" href="#" @click.prevent="showFeedbacks = true">
          [{{user.name}}]
        </a>
      </span>
    </span>
    <a v-if="canGiveFeedback(idea)" href="#" @click.prevent="newFeedback = true">Dar Feedback</a>
    <show-feedbacks-modal v-if="showFeedbacks" @close="showFeedbacks = false"/>
    <new-feedback-modal v-if="newFeedback" @close="newFeedback = false"/>
  </p>
</template>

<script>
import NewFeedbackModal from '@/components/feedbacks/NewFeedbackModal'
import ShowFeedbacksModal from '@/components/feedbacks/ShowFeedbacksModal'

export default {
  components: {
    NewFeedbackModal,
    ShowFeedbacksModal
  },
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
  data () {
    return {
      showFeedbacks: false,
      newFeedback: false
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
  span.feedbacks {
    font-size: 12px;
    color: gray;
  }
</style>
