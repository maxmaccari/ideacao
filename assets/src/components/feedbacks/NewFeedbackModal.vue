<template>
  <div id="newFeedbackModal" class="modal">
    <div class="modal-content left-align">
      <h4>Novo Feedback para {{idea.title}}</h4>
      <p>Como você avalia o {{idea.title}}? Dê uma nota e diga o que você achou dessa ideia.</p>
      <form>
        <div>
          <label>Nota (de 0 a 10)</label>
          <div>
            <star-rating
              v-model="feedback.rating"
              :increment="0.5"
              :max-rating="10"
              :star-size="40"
              :roundedCorners="true"
              :text-class="'rating-text'"
              :inline="true" />
            <a href="#"
               class="btn-floating btn-small waves-effect waves-light clear-rating waves-yellow amber"
               @click="feedback.rating = 0" :class="{disabled: zeroRating}">
              <i class="material-icons">delete</i>
            </a>
          </div>
        </div>
        <div class="input-field">
          <textarea id="comment" v-model="feedback.comment" name="comment" class="materialize-textarea" required/>
          <label for="comment">Comentário</label>
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
import M from 'materialize-css'
import StarRating from 'vue-star-rating'

export default {
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
      modal: null,
      feedback: {
        rating: 0,
        comment: "",
        user: {
          id: 1,
          name: "Maxsuel"
        }
      }
    }
  },
  mounted () {
    const vm = this
    const elem = document.getElementById("newFeedbackModal")
    const modal = M.Modal.init(elem, {
          onCloseEnd () {
            vm.$emit('close')
          }
        })

    this.modal = modal;

    modal.open()
  },
  methods: {
    add () {
      if (this.valid) {
        this.$emit('add', this.feedback)
        this.modal.close()
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
  }
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
