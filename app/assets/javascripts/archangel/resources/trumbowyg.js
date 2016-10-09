$.fn.inputTextareaWysiwyg = function () {
  "use strict";

  this.trumbowyg({
    autogrow: true,
    fullscreenable: false,
    removeformatPasted: true,
    resetCss: true,
    semantic: true,
    btns: [
      ["undo", "redo"],
      ["preformatted"],
      ["formatting"],
      ["strong", "em", "underline", "strikethrough", "superscript", "subscript"],
      ["link"],
      ["images"],
      ["justify"],
      ["lists"],
      ["viewHTML"]
    ],
    btnsDef: {
      images: {
        dropdown: ["insertImage", "upload", "base64", "noembed"],
        ico: "insertImage"
      },
      justify: {
        dropdown: ["justifyLeft", "justifyCenter", "justifyRight", "justifyFull"],
        ico: "justifyLeft"
      },
      lists: {
        dropdown: ["unorderedList", "orderedList"],
        ico: "unorderedList"
      }
    },
    plugins: {
      upload: {
        serverPath: "/admin/assets",
        fileFieldName: "file"
      }
    }
  })
  .on("focus tbwfocus", function() {
    $(this).parent(".trumbowyg-box").toggleClass("focus", true);
  })
  .on("blur tbwblur", function() {
    $(this).parent(".trumbowyg-box").toggleClass("focus", false);
  });
};

$(function() {

  $("textarea.wysiwyg").inputTextareaWysiwyg();

});
