document.addEventListener("turbolinks:load", function() {
  $('.image-popout').magnificPopup({type:'image'});
});


$(document).ready(function(){
  $('#tab-list').click(function (e) {
    e.preventDefault()
    $(this).tab('show')
  })

});
