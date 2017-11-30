//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require underscore
//= require gmaps/google
//= require jquery-fileupload/basic
//= require cloudinary/jquery.cloudinary
//= require attachinary
//= require bootstrap-datepicker
//= require moment
//= require fullcalendar
//= require rails.validations
//= require rails.validations.simple_form
//= require_tree .

$('.datepicker').datepicker({
  format: 'yyyy-mm-dd',
  autoclose: true,
  todayHighlight: true,
  startDate: new Date(),
});

$('#calendar').fullCalendar({
  events: '/requests.json'
});
