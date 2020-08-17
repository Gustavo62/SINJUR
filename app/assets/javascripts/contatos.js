function ConfirmDelete(button) {
  alertify.confirm("Você realmente deseja excuir", function() {
    button.form.submit() 
  }, function() {
    alertify.error("Você cancelou a ação");
  }).set('defaultFocus', 'Cancelar');

  return false;
}
