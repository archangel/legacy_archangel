$(function () {

  // Date/datetime tooltips
  var datetimepicker_tooltips = {
    clear:        Archangel.translations.datetimepicker.clear,
    close:        Archangel.translations.datetimepicker.close,
    nextCentury:  Archangel.translations.datetimepicker.next_century,
    nextDecade:   Archangel.translations.datetimepicker.next_decade,
    nextMonth:    Archangel.translations.datetimepicker.next_month,
    nextYear:     Archangel.translations.datetimepicker.next_year,
    prevCentury:  Archangel.translations.datetimepicker.prev_century,
    prevDecade:   Archangel.translations.datetimepicker.prev_decade,
    prevMonth:    Archangel.translations.datetimepicker.prev_month,
    prevYear:     Archangel.translations.datetimepicker.prev_year,
    selectDecade: Archangel.translations.datetimepicker.select_decade,
    selectMonth:  Archangel.translations.datetimepicker.select_month,
    selectYear:   Archangel.translations.datetimepicker.select_year,
    today:        Archangel.translations.datetimepicker.today
  };

  // Date picker
  $('input.datepicker').datetimepicker({
    format:    Archangel.translations.datetimepicker.format,
    showClear: true,
    tooltips:  datetimepicker_tooltips
  });

  // Date time picker
  $('input.datetimepicker').datetimepicker({
    format:    Archangel.translations.datetimepicker.time_format,
    showClear: true,
    stepping:  5,
    tooltips:  datetimepicker_tooltips
  });

});
