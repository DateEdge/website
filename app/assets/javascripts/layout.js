$(document).ready(function() {
  $('img').error(function() {
    $(this).prop('src', "/assets/placeholder.png")
  });
});
