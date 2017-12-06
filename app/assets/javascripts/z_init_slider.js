// Instantiate a slider
var mySlider = new Slider("#room_monthly_price", {
	min: 100,
  max: 2000,
  step: 50,
	value: 1200,
  tooltip: 'always',
});

var value = mySlider.getValue();

mySlider.setValue(value)
