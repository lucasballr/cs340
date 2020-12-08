function deleteCar(id){
  $.ajax({
    url: '/cars/' + id,
    type: 'DELETE',
    success: function(result){
      window.location.reload(true);
    }
  })
};
