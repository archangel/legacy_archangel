$(function() {

  tinyMCE.init({
    selector: "textarea.wysiwyg",
    image_advtab: true,
    image_class_list: [
      // TODO: Need translations for the titles
      { title: "None", value: "" },
      { title: "Responsive", value: "img-responsive" },
      { title: "Rounded", value: "img-rounded" },
      { title: "Circle", value: "img-circle" },
      { title: "Thumbnail", value: "img-thumbnail" }
    ],
    image_description: true,
    image_dimensions: true,
    image_title: true,
    menubar: false,
    plugins: [
      "autoresize",
      "code",
      "image",
      "link",
      "lists",
      "media",
      "uploadimage",
      "visualblocks"
    ],
    statusbar: false,
    toolbar: "undo redo | styleselect | bullist numlist outdent indent | link image uploadimage media | " +
             "visualblocks | code",
    uploadimage_form_url: "/admin/assets" // TODO: This needs to be dynamic
  });

});
