$.fn.inputTextMetaKeywords = function () {
  "use strict";

  var formatMetaKeywordOption = function(data) {
    return data.text.toLowerCase();
  }

  this.select2({
    templateResult: formatMetaKeywordOption,
    templateSelection: formatMetaKeywordOption,
    minimumInputLength: 2,
    multiple: true,
    tags: true,
    tokenSeparators: [","]
  });
};

$(function() {

  $("select.meta_keywords").inputTextMetaKeywords();

});
