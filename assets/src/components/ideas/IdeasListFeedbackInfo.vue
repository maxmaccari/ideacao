<template>
  <p class="right-align">
    <span class="left">
      <star-rating v-model="average"
              :increment="0.01"
              :readOnly="true"
              :max-rating="10"
              :star-size="20"
              :roundedCorners="true"
              :inline="true" />
    </span>
    <span class="feedbacks">
      <span v-if="count > 0">
        <a href="#" @click.prevent="showFeedbacks = true" v-if="count > 1">{{count}} feedbacks</a>
        <a href="#" @click.prevent="showFeedbacks = true" v-else>{{count}} feedback</a> até o momento.
        <a v-if="canGiveFeedback(idea)" href="#" @click.prevent="newFeedback = true">
          Dê o seu feedback também!
        </a>
      </span>
      <span v-else>
        Nenhum feedback até o momento.
        <a v-if="canGiveFeedback(idea)" href="#" @click.prevent="newFeedback = true">
          Seja o primeiro a dar um!
        </a>
      </span>
    </span>
    <show-feedbacks-modal :idea="idea" v-if="showFeedbacks" @close="showFeedbacks = false"/>
    <new-feedback-modal :idea="idea" @add="addFeedback" v-if="newFeedback" @close="newFeedback = false"/>
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
    }
  },
  methods: {
    canGiveFeedback (idea) {
      return !this.idea.feedbacks.some(feedback => feedback.user.id == this.user.id);
    },
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
