$('#form-intro .next').on("click", function(){
  $("#form-intro").hide("fade", { easing: "easeInQuart", direction: "left" }, 700, function(){
    $("#arts-container").show("fade", { easing: "easeOutQuart", direction: "right" }, 700);
  });
});

$('#arts-container .next').on("click", function(){
  $("#arts-container").hide("fade", { easing: "easeInQuart", direction: "left" }, 700, function(){
    $("#sports-container").show("fade", { easing: "easeOutQuart", direction: "right" }, 700);
  });
});

$('#arts-container .back').on("click", function(){
  $("#arts-container").hide("fade", { easing: "easeInQuart", direction: "right" }, 700, function(){
    $("#form-intro").show("fade", { easing: "easeOutQuart", direction: "left" }, 700);
  });
});

$('#sports-container .next').on("click", function(){
  $("#sports-container").hide("fade", { easing: "easeInQuart", direction: "left" }, 700, function(){
    $("#films-container").show("fade", { easing: "easeOutQuart", direction: "right" }, 700);
  });
});

$('#sports-container .back').on("click", function(){
  $("#sports-container").hide("fade", { easing: "easeInQuart", direction: "right" }, 700, function(){
    $("#arts-container").show("fade", { easing: "easeOutQuart", direction: "left" }, 700);
  });
});

$('#films-container .next').on("click", function(){
  $("#films-container").hide("fade", { easing: "easeInQuart", direction: "left" }, 700, function(){
    $("#music-container").show("fade", { easing: "easeOutQuart", direction: "right" }, 700);
  });
});

$('#films-container .back').on("click", function(){
  $("#films-container").hide("fade", { easing: "easeInQuart", direction: "right" }, 700, function(){
    $("#sports-container").show("fade", { easing: "easeOutQuart", direction: "left" }, 700);
  });
});

$('#music-container .next').on("click", function(){
  $("#music-container").hide("fade", { easing: "easeInQuart", direction: "left" }, 700, function(){
    $("#holidays-container").show("fade", { easing: "easeOutQuart", direction: "right" }, 700);
  });
});

$('#music-container .back').on("click", function(){
  $("#music-container").hide("fade", { easing: "easeInQuart", direction: "right" }, 700, function(){
    $("#films-container").show("fade", { easing: "easeOutQuart", direction: "left" }, 700);
  });
});

$('#holidays-container .next').on("click", function(){
  $("#holidays-container").hide("fade", { easing: "easeInQuart", direction: "left" }, 700, function(){
    $("#food-container").show("fade", { easing: "easeOutQuart", direction: "right" }, 700);
  });
});

$('#holidays-container .back').on("click", function(){
  $("#holidays-container").hide("fade", { easing: "easeInQuart", direction: "right" }, 700, function(){
    $("#music-container").show("fade", { easing: "easeOutQuart", direction: "left" }, 700);
  });
});

$('#food-container .back').on("click", function(){
  $("#food-container").hide("fade", { easing: "easeInQuart", direction: "right" }, 700, function(){
    $("#holidays-container").show("fade", { easing: "easeOutQuart", direction: "left" }, 700);
  });
});

$('#food-container .next').on("click", function(){
  $("#food-container").hide("fade", { easing: "easeInQuart", direction: "left" }, 700, function(){
    $("#form-outro").show("fade", { easing: "easeOutQuart", direction: "right" }, 700);
  });
  window.setTimeout(function() {
    $("#interest-form").submit();
  }, 3000);
});




