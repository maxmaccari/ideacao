<template>
  <div id="showFeedbacksModal" class="modal">
    <div class="modal-content left-align">
      <h4>Feedbacks de ideias de Maxsuel</h4>
      <p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Laborum adipisci aut quia rem porro? Optio similique dolorem aspernatur praesentium, quod consectetur minima nobis sint possimus! Nesciunt asperiores recusandae numquam dolorem vitae. Ipsam iste fugit adipisci minus est hic tempora molestias?</p>
    </div>
    <div class="modal-footer">
      <a class="btn-flat waves-effect waves-red" @click.prevent="modal.close()">Fechar</a>
    </div>
  </div>
</template>

<script>
import M from 'materialize-css'

export default {
  data () {
    return {
      modal: null
    }
  },
  mounted () {
    const vm = this
    const elem = document.getElementById("showFeedbacksModal")
    const modal = M.Modal.init(elem, {
          onCloseEnd () {
            vm.$emit('close')
          }
        })

    this.modal = modal;

    modal.open()
  }
}
</script>

<style scoped>
  .modal-content p {
    text-align: justify;
  }
</style>
