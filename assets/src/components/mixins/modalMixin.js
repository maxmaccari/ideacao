import M from 'materialize-css'

export default {
  data: function () {
    return {
      modal: null
    }
  },
  mounted () {
    const vm = this
    const elem = document.getElementById(this.modalName)
    const modal = M.Modal.init(elem, {
      onCloseEnd() {
        vm.$emit('close')
      }
    })

    this.modal = modal;

    modal.open()
  }
}
