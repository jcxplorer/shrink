jQuery(function() {
  
  $("#flash").hide().fadeIn();
  setTimeout('$("#flash").fadeOut()', 5000);

  $("a[data-tab]:first").addClass("active");

  $("div[data-tab]").hide(); 
  $("div[data-tab]:first").show();

  $("a[data-tab]").click(function() {
    var tab = $(this).attr("data-tab");
    $(".tab[data-tab='" + tab + "']").show().siblings("div").hide();
    $(this).addClass("active").siblings().removeClass("active");
    return false;
  });

});
