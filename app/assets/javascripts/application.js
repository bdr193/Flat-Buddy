//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require underscore
//= require gmaps/google
//= require bootstrap-toggle
//= require jquery-fileupload/basic
//= require cloudinary/jquery.cloudinary
//= require attachinary
//= require bootstrap-datepicker
//= require jquery-ui
//= require moment
//= require fullcalendar
//= require rails.validations
//= require rails.validations.simple_form
//= require_tree .

$('#calendar').fullCalendar({
  events: '/requests.json'
});
