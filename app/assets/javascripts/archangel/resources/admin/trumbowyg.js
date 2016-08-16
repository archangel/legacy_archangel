$.fn.inputTextareaWysiwyg = function () {
  "use strict";

  this.trumbowyg({
    autogrow: true,
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
    },
    fullscreenable: false,
    removeformatPasted: true,
    resetCss: true,
    semantic: true
  });
};

$(function() {

  $("textarea.wysiwyg").inputTextareaWysiwyg();

});
