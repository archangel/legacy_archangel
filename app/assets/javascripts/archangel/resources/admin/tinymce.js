$(function() {

  tinyMCE.init({
    selector: "textarea.wysiwyg",
    menubar: false,
    statusbar: false,
    // theme: "modern",
    plugins: [
      "link", "image", "lists", "media"
    ],
    toolbar: "undo redo | styleselect | bullist numlist outdent indent | link image media",
    image_advtab: true
  });

});
