<template>
  <div :id="modalName" class="modal">
    <div class="modal-content left-align">
      <h4>Novo Feedback para {{idea.title}}</h4>
      <p>Como você avalia o {{idea.title}}? Dê uma nota e diga o que você achou dessa ideia.</p>
      <form>
        <div>
          <label>De 0 a 10, que nota você dá para essa ideia? (se for zero, não selecione nenhuma estrelinha)</label>
          <div>
            <star-rating
              v-model="feedback.rating"
              :increment="0.5"
              :max-rating="10"
              :star-size="40"
              :rounded-corners="true"
              :text-class="'rating-text'"
              :inline="true" />
            <a :class="{disabled: zeroRating}"
               href="#"
               class="btn-floating btn-small waves-effect waves-light clear-rating waves-yellow amber" @click="feedback.rating = 0">
              <i class="material-icons">delete</i>
            </a>
          </div>
        </div>
        <div class="input-field">
          <textarea id="comment" v-model="feedback.comment" name="comment" class="materialize-textarea" required/>
          <label for="comment">Por que essa nota?</label>
        </div>
      </form>
    </div>
    <div class="modal-footer">
      <a class="btn-flat waves-effect waves-red" @click.prevent="modal.close()">Cancelar</a>
      <a :class="{disabled: !valid}" class="btn-flat waves-effect waves-green" @click.prevent="add">Enviar <i class="material-icons right">send</i></a>
    </div>
  </div>
</template>

<script>
import StarRating from 'vue-star-rating'
import modalMixin from '@/components/mixins/modalMixin'

export default {
  components: {
    StarRating
  },
  mixins: [modalMixin],
  props: {
    idea: {
      type: Object,
      required: true
    }
  },
  data () {
    return {
      modalName: 'newFeedbackModal',
      feedback: {
        rating: 0,
        comment: ""
      }
    }
  },
  computed: {
    zeroRating () {
      return this.feedback.rating == 0
    },
    valid () {
      return this.feedback.comment.length > 3
    }
  },
  methods: {
    add () {
      if (this.valid) {
        this.$emit('add', {
          idea: this.idea,
          feedback: this.feedback
        })
        this.modal.close()
      }
    }
  },
}
</script>

<style>
  .rating-text {
    border: 4px dashed #ffd055;
    border-radius: 25px;
    font-size: 24px;
    margin-left: 12px;
    margin-top: 3px;
    text-align: center;
    width: 56px;
  }

  .clear-rating {
    vertical-align: text-bottom;
    margin-left: 6px;
  }
</style>
