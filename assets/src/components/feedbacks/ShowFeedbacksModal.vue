<template>
  <div :id="modalName" class="modal">
    <div class="modal-content left-align">
      <h4>Feedbacks para {{idea.title}}</h4>

      <div v-for="feedback in idea.feedbacks" :key="feedback.id" class="feedback">
        <h5>Feedback de {{feedback.user.name}}</h5>
        <p>Nota:
          <star-rating v-model="feedback.rating"
                       :increment="0.5"
                       :read-only="true"
                       :max-rating="10"
                       :star-size="20"
                       :rounded-corners="true"
                       :text-class="'summary-rating-text'"
                       :inline="true" />
        </p>
        <p>{{feedback.comment}}</p>
        <div class="divider"/>
      </div>


    </div>
    <div class="modal-footer">
      <span class="left summary">
        <span v-if="count > 1"><b>Total: </b>{{count}} feedbacks</span>
        <span v-else class="col s12 m3"><b>Total: </b>{{count}} feedback</span>
        <span class="col s12 m3"><b>Nota Média: </b>
          <star-rating v-model="average"
                       :increment="0.01"
                       :read-only="true"
                       :max-rating="10"
                       :star-size="20"
                       :rounded-corners="true"
                       :text-class="'summary-rating-text'"
                       :inline="true" />
        </span>
      </span>
      <a class="btn-flat waves-effect waves-red" @click.prevent="modal.close()">Fechar</a>
    </div>
  </div>
</template>

<script>
import StarRating from 'vue-star-rating'
import modalMixin from '@/components/mixins/modalMixin'

export default {
  mixins: [modalMixin],
  components: {
    StarRating
  },
  props: {
    idea: {
      type: Object,
      required: true
    }
  },
  data () {
    return {
      modalName: 'showFeedbacksModal'
    }
  },
  computed: {
    count () {
      return this.idea.feedbacks.length
    },
    average () {
      const sum = this.idea.feedbacks
        .reduce((sum, feedback) => sum + feedback.rating, 0)

      return sum / this.count
    }
  }
}
</script>

<style scoped>
  .modal-content p {
    text-align: justify;
  }

  .summary {
    margin-left: 15px;
  }

  .summary span {
    margin-right: 25px
  }
</style>

<style>
  .summary-rating-text {
    border-radius: 25px;
    font-size: 24px;
    margin-left: 12px;
    text-align: center;
    width: 15px;
  }
</style>
