// Instantiate a slider
$(document).ready(function(){
	var regex = /monthly_price%5D=(\d+)&/;
	var loc = window.location.search;
	if (loc.length > 1) {
		var val = parseInt(loc.match(regex)[1]);
	}


	if ($("#room_monthly_price").length != 0) {
		var mySlider = new Slider("#room_monthly_price", {
			min: 100,
		  max: 2000,
		  step: 50,
			value:  val || 1200,
		  tooltip: 'always',
		});
	}
});
