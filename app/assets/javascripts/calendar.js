
$(document).ready(function(){
  $('#modal-calendar').on('shown.bs.modal', function(){
    $('#calendar').fullCalendar({
      events: '/requests.json'
    });
  });
});

// $('#calendar').fullCalendar({
//   events: '/requests.json'
// });
