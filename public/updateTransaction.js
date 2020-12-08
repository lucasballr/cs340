function updateTransaction(id){

  $.ajax({
    url: '/transactions/' + id,
    type: 'PUT',
    data: $('#update-transaction').serialize(),
    success: function(result){
      window.location.replace("./");
    }
  })
};
