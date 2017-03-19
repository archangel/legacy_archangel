$.fn.inputSelectCategories = function () {
  'use strict';

  this.select2({
    minimumInputLength: 1,
    multiple: true,
    theme: 'bootstrap',
    ajax: {
      cache: true,
      datatype: 'json',
      delay: 500,
      url: '/admin/categories/autocomplete.json',
      width: '100%',
      data: function (params) {
        return {
          q: params.term
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
  'use strict';

  $('select.categories').inputSelectCategories();

});
