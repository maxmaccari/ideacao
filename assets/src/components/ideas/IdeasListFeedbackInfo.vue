<template>
  <p class="right-align">
    <span class="left">
      <star-rating v-model="average"
                   :increment="0.01"
                   :read-only="true"
                   :max-rating="10"
                   :star-size="20"
                   :rounded-corners="true"
                   :inline="true" />
    </span>
    <span class="feedbacks">
      <span v-if="count > 0">
        <a v-if="count > 1" href="#" @click.prevent="showFeedbacks = true">{{count}} feedbacks</a>
        <a v-else href="#" @click.prevent="showFeedbacks = true">{{count}} feedback</a> até o momento.
        <a v-if="canGiveFeedback" href="#" @click.prevent="newFeedback = true">
          Dê o seu feedback também!
        </a>
      </span>
      <span v-else>
        Nenhum feedback até o momento.
        <a v-if="canGiveFeedback" href="#" @click.prevent="newFeedback = true">
          Seja o primeiro a dar um!
        </a>
      </span>
    </span>
    <show-feedbacks-modal v-if="showFeedbacks" :idea="idea" @close="showFeedbacks = false"/>
    <new-feedback-modal v-if="newFeedback" :idea="idea" @add="addFeedback" @close="newFeedback = false"/>
  </p>
</template>

<script>
import NewFeedbackModal from '@/components/feedbacks/NewFeedbackModal'
import ShowFeedbacksModal from '@/components/feedbacks/ShowFeedbacksModal'
import StarRating from 'vue-star-rating'

export default {
  components: {
    NewFeedbackModal,
    ShowFeedbacksModal,
    StarRating
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
  computed: {
    count () {
      return this.idea.feedbacks.length
    },
    average () {
      if (this.count > 0) {
        const sum = this.idea.feedbacks
          .reduce((sum, feedback) => sum + feedback.rating, 0)

        return sum / this.count
      }
    },
    canGiveFeedback () {
      return !this.idea.feedbacks.some(feedback => feedback.user.id == this.user.id);
    }
  },
  methods: {
    addFeedback (feedback) {
      this.idea.feedbacks.push(feedback)
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
