function updateEmployee(id){

  $.ajax({
    url: '/employees/' + id,
    type: 'PUT',
    data: $('#update-employee').serialize(),
    success: function(result){
      window.location.replace("./");
    }
  })
};
