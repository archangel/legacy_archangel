$.fn.inputSelectTags = function () {
  "use strict";

  var formatTagOption = function(tag) {
    return Select2.util.escapeMarkup(tag.name);
  }

  this.select2({
    minimumInputLength: 1,
    multiple: true,
    ajax: {
      cache: true,
      datatype: "json",
      delay: 500,
      formatResult: formatTagOption,
      formatSelection: formatTagOption,
      url: "/admin/tags/autocomplete.json",
      data: function (term) {
        return {
          q: term
        };
      },
      processResults: function (data) {
        var results = data ? data : [];

        return {
          results: $.map(results, function(res) {
            return { id: res.id, text: res.name };
          })
        };
      }
    }
  });
};

$(function() {

  $("select.tags").inputSelectTags();

});
