function deleteDealership(id){
  $.ajax({
    url: '/dealerships/' + id,
    type: 'DELETE',
    success: function(result){
      window.location.reload(true);
    }
  })
};
