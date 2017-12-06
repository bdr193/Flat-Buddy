$('.datepicker').datepicker({
  format: 'yyyy-mm-dd',
  autoclose: true,
  todayHighlight: true,
  startDate: new Date(),
});

$('#calendar').fullCalendar({
  events: '/requests.json'
});
