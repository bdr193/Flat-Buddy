// Instantiate a slider
var mySlider = new Slider("#room_monthly_price", {
	min: 100,
  max: 2000,
  step: 50,
	value: 1200,
  tooltip: 'always',
});

var value = mySlider.getValue();
console.log("the current value is");
console.log(value);

console.log("setting the value");
mySlider.setValue(value)
