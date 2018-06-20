<template>
  <div id="newFeedbackModal" class="modal">
    <div class="modal-content left-align">
      <h4>Novo Feedback na ideia #ideia</h4>
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
    const elem = document.getElementById("newFeedbackModal")
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

<style>

</style>
