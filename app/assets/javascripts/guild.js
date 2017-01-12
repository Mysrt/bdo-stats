$(document).ready(function(){
  $('#tab-list').click(function (e) {
    e.preventDefault()
    $(this).tab('show')
  })
  $('.image-popout').magnificPopup({type:'image'});
  
});
