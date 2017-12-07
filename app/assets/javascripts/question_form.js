$('#form-intro .next').on("click", function(){
  $("#form-intro").hide("slide", { easing: "easeInQuart", direction: "left" }, 700, function(){
    $("#arts-container").show("slide", { easing: "easeOutQuart", direction: "right" }, 700);
  });
});

$('#arts-container .next').on("click", function(){
  $("#arts-container").hide("slide", { easing: "easeInQuart", direction: "left" }, 700, function(){
    $("#sports-container").show("slide", { easing: "easeOutQuart", direction: "right" }, 700);
  });
});

$('#arts-container .back').on("click", function(){
  $("#arts-container").hide("slide", { easing: "easeInQuart", direction: "right" }, 700, function(){
    $("#form-intro").show("slide", { easing: "easeOutQuart", direction: "left" }, 700);
  });
});

$('#sports-container .next').on("click", function(){
  $("#sports-container").hide("slide", { easing: "easeInQuart", direction: "left" }, 700, function(){
    $("#films-container").show("slide", { easing: "easeOutQuart", direction: "right" }, 700);
  });
});

$('#sports-container .back').on("click", function(){
  $("#sports-container").hide("slide", { easing: "easeInQuart", direction: "right" }, 700, function(){
    $("#arts-container").show("slide", { easing: "easeOutQuart", direction: "left" }, 700);
  });
});

$('#films-container .next').on("click", function(){
  $("#films-container").hide("slide", { easing: "easeInQuart", direction: "left" }, 700, function(){
    $("#music-container").show("slide", { easing: "easeOutQuart", direction: "right" }, 700);
  });
});

$('#films-container .back').on("click", function(){
  $("#films-container").hide("slide", { easing: "easeInQuart", direction: "right" }, 700, function(){
    $("#sports-container").show("slide", { easing: "easeOutQuart", direction: "left" }, 700);
  });
});

$('#music-container .next').on("click", function(){
  $("#music-container").hide("slide", { easing: "easeInQuart", direction: "left" }, 700, function(){
    $("#food-container").show("slide", { easing: "easeOutQuart", direction: "right" }, 700);
  });
});

$('#music-container .back').on("click", function(){
  $("#music-container").hide("slide", { easing: "easeInQuart", direction: "right" }, 700, function(){
    $("#films-container").show("slide", { easing: "easeOutQuart", direction: "left" }, 700);
  });
});

$('#food-container .back').on("click", function(){
  $("#food-container").hide("slide", { easing: "easeInQuart", direction: "right" }, 700, function(){
    $("#music-container").show("slide", { easing: "easeOutQuart", direction: "left" }, 700);
  });
});

$('#food-container .next').on("click", function(){
  $("#food-container").hide("slide", { easing: "easeInQuart", direction: "left" }, 700, function(){
    $("#form-outro").show("slide", { easing: "easeOutQuart", direction: "right" }, 700);
  });
  window.setTimeout(function() {
    $("#interest-form").submit();
  }, 3000);
});




