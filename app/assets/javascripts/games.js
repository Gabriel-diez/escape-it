$(function() {
  $(document).ready(function() {
    setInterval(function() {
      $.ajax({
        url: "/games",
        type: "GET",
        dataType: "script"
      });
    }, 10000);

    $(document).ajaxStart(function() {
      $('#loadingSpinner').show();
    }).ajaxStop(function() {
      $('#loadingSpinner').hide();
    });
  });
});
