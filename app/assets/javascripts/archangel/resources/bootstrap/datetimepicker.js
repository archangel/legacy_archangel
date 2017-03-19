$(function() {
  'use strict';

  // Date/datetime tooltips
  var archangelDatetimepickerTranslations = function() {
    return {
      clear:        Archangel.translation.datetimepicker.clear,
      close:        Archangel.translation.datetimepicker.close,
      nextCentury:  Archangel.translation.datetimepicker.next_century,
      nextDecade:   Archangel.translation.datetimepicker.next_decade,
      nextMonth:    Archangel.translation.datetimepicker.next_month,
      nextYear:     Archangel.translation.datetimepicker.next_year,
      prevCentury:  Archangel.translation.datetimepicker.prev_century,
      prevDecade:   Archangel.translation.datetimepicker.prev_decade,
      prevMonth:    Archangel.translation.datetimepicker.prev_month,
      prevYear:     Archangel.translation.datetimepicker.prev_year,
      selectDecade: Archangel.translation.datetimepicker.select_decade,
      selectMonth:  Archangel.translation.datetimepicker.select_month,
      selectYear:   Archangel.translation.datetimepicker.select_year,
      today:        Archangel.translation.datetimepicker.today
    };
  };

  // Time picker
  $('input.timepicker').datetimepicker({
    format:    Archangel.translation.datetimepicker.time_format,
    showClear: true,
    stepping:  5,
    tooltips:  archangelDatetimepickerTranslations
  });

  // Date picker
  $('input.datepicker').datetimepicker({
    format:    Archangel.translation.datetimepicker.date_format,
    showClear: true,
    tooltips:  archangelDatetimepickerTranslations
  });

  // Date time picker
  $('input.datetimepicker').datetimepicker({
    format:    Archangel.translation.datetimepicker.format,
    showClear: true,
    stepping:  5,
    tooltips:  archangelDatetimepickerTranslations
  });

});
