$.fn.inputSelectCategories = function () {
  "use strict";

  var formatCategoryOption = function(category) {
    return Select2.util.escapeMarkup(category.name);
  }

  this.select2({
    minimumInputLength: 1,
    multiple: true,
    ajax: {
      cache: true,
      datatype: "json",
      delay: 500,
      formatResult: formatCategoryOption,
      formatSelection: formatCategoryOption,
      url: "/admin/categories/autocomplete.json",
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

  $("select.categories").inputSelectCategories();

});
