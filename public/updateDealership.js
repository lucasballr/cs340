function updateDealership(id){
  $.ajax({
    url: '/dealerships/' + id,
    type: 'PUT',
    data: $('#update-dealership').serialize(),
    success: function(result){
      window.location.replace("./");
    }
  })
};
