$(function () {

  // Date picker
  $('.datepicker').datetimepicker({
    format: Archangel.translations.date_picker_format
  });

  // Date time picker
  $('.datetimepicker').datetimepicker({
    format: Archangel.translations.date_time_picker_format
  });

  // Remove date
  $('.datepicker-remove, .datetimepicker-remove').on('click', function() {
    $(this).parent().children('.datepicker, .datetimepicker').val('');
  });

});
