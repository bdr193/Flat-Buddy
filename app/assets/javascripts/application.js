//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require jquery-fileupload/basic
//= require cloudinary/jquery.cloudinary
//= require attachinary
//= require_tree .
$('.datepicker').datepicker({
  format: 'yyyy-mm-dd',
  autoclose: true,
  todayHighlight: true,
  startDate: new Date(),
});
