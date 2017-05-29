$(function(){
  'use strict';

  var
    defaultMenuToggle = function() {
      return (smallWindowWidth()) ? false : getLocalStorage();
    },
    resizeMenuToggle = function() {
      if (smallWindowWidth()) {
        return false;
      }

      return getLocalStorage();
    },
    documentObject = $(document),
    getLocalStorage = function() {
      if ( ! localStorageAvailable()) {
        return true;
      }

      return localStorage.getItem(localStorageKey) === 'true';
    },
    localStorageAvailable = function() {
      return typeof(Storage) !== 'undefined';
    },
    localStorageKey = 'archangel-default-menu-collapsed',
    setLocalStorage = function(toggled) {
      localStorage.setItem(localStorageKey, toggled);
    },
    sidebarContainerObject = $('.page-display'),
    sidebarToggleClass = 'sidebar-open',
    sidebarToggleObject = $('.sidebar-toggle'),
    smallWindowWidth = function() {
      return windowWidth() < windowMaxWidth;
    },
    toggleSidebar = function(toggled) {
      sidebarContainerObject.toggleClass(sidebarToggleClass, toggled);
    },
    windowMaxWidth = 720,
    windowObject = $(window),
    windowWidth = function() {
      return windowObject.width();
    };

  documentObject.ready(function () {
    toggleSidebar(defaultMenuToggle());

    sidebarToggleObject.on('click', function(evt){
      evt.preventDefault();

      var toggled = ! sidebarContainerObject.hasClass(sidebarToggleClass);

      setLocalStorage(toggled);
      toggleSidebar(toggled);
    });
  });

  windowObject.resize(function() {
    toggleSidebar(resizeMenuToggle());
  });

});
