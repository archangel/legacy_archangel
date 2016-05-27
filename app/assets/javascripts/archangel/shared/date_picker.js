// Date/datetime tooltips
var archangelDatetimepickerTranslations = function() {
  return {
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
};

// Date picker
$('input.datepicker').datetimepicker({
  format:    archangelDatetimepickerTranslations.format,
  showClear: true,
  tooltips:  archangelDatetimepickerTranslations
});

// Date time picker
$('input.datetimepicker').datetimepicker({
  format:    archangelDatetimepickerTranslations.time_format,
  showClear: true,
  stepping:  5,
  tooltips:  archangelDatetimepickerTranslations
});
