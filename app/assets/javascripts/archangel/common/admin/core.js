// Admin core for Archangel
//
//= require_self
//
//= require archangel/common/archangel

//http://stackoverflow.com/questions/16786826/javascript-module-pattern-how-to-inject-create-extend-methods-plugin-to-our-own

// var Archangel = (function(object) {
//
//   // private variable to store id of a box
//   var box = '';
//
//   object.getById = function(id) {
//
//     box = document.getElementById(id);
//     return this;
//   };
//
//   object.setColor = function(newcolor) {
//
//     box.style.background = newcolor;
//     return this;
//
//   };
//
//   object.setAnotherColor = function(newcolor) {
//
//     var box = document.getElementById('colorbox4');
//     box.style.background = newcolor;
//
//   };
//
//   return object; // return the extended object
//
// }(Archangel));
