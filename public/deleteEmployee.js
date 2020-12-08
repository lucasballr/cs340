function deleteEmployee(id){
  $.ajax({
    url: '/employees/' + id,
    type: 'DELETE',
    success: function(result){
      window.location.reload(true);
    }
  })
};
