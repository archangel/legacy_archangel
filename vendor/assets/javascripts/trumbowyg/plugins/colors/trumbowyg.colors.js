!function(o){"use strict";function r(o){return("0"+parseInt(o).toString(16)).slice(-2)}function e(o){return-1===o.search("rgb")?o.replace("#",""):"rgba(0, 0, 0, 0)"===o?"transparent":(o=o.match(/^rgba?\((\d+),\s*(\d+),\s*(\d+)(?:,\s*(\d+))?\)$/),r(o[1])+r(o[2])+r(o[3]))}function f(o,r){var f=[];if(""!==o.style.backgroundColor){var c=e(o.style.backgroundColor);r.o.plugins.colors.colorList.indexOf(c)>=0?f.push("backColor"+c):f.push("backColorFree")}var a;return""!==o.style.color?a=e(o.style.color):o.hasAttribute("color")&&(a=e(o.getAttribute("color"))),a&&(r.o.plugins.colors.colorList.indexOf(a)>=0?f.push("foreColor"+a):f.push("foreColorFree")),f}function c(r,e){var f=[];o.each(e.o.plugins.colors.colorList,function(o,c){var a=r+c,d={fn:r,forceCss:!0,param:"#"+c,style:"background-color: #"+c+";"};e.addBtnDef(a,d),f.push(a)});var c=r+"Remove",a={fn:"removeFormat",param:r,style:"background-image: url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAQAAAAECAYAAACp8Z5+AAAAG0lEQVQIW2NkQAAfEJMRmwBYhoGBYQtMBYoAADziAp0jtJTgAAAAAElFTkSuQmCC);"};e.addBtnDef(c,a),f.push(c);var d=r+"Free",t={fn:function(){e.openModalInsert(e.lang[r],{color:{label:r,value:"#FFFFFF"}},function(o){return e.execCmd(r,o.color),!0})},text:"#",style:"text-indent: 0;line-height: 20px;padding: 0 5px;"};return e.addBtnDef(d,t),f.push(d),f}o.extend(!0,o.trumbowyg,{langs:{cs:{foreColor:"Barva textu",backColor:"Barva pozadí"},en:{foreColor:"Text color",backColor:"Background color"},fr:{foreColor:"Couleur du texte",backColor:"Couleur de fond"},sk:{foreColor:"Farba textu",backColor:"Farba pozadia"},zh_cn:{foreColor:"文字颜色",backColor:"背景颜色"}}});var a={colorList:["ffffff","000000","eeece1","1f497d","4f81bd","c0504d","9bbb59","8064a2","4bacc6","f79646","ffff00","f2f2f2","7f7f7f","ddd9c3","c6d9f0","dbe5f1","f2dcdb","ebf1dd","e5e0ec","dbeef3","fdeada","fff2ca","d8d8d8","595959","c4bd97","8db3e2","b8cce4","e5b9b7","d7e3bc","ccc1d9","b7dde8","fbd5b5","ffe694","bfbfbf","3f3f3f","938953","548dd4","95b3d7","d99694","c3d69b","b2a2c7","b7dde8","fac08f","f2c314","a5a5a5","262626","494429","17365d","366092","953734","76923c","5f497a","92cddc","e36c09","c09100","7f7f7f","0c0c0c","1d1b10","0f243e","244061","632423","4f6128","3f3151","31859b","974806","7f6000"]};o.extend(!0,o.trumbowyg,{plugins:{color:{init:function(r){r.o.plugins.colors=o.extend(!0,{},a,r.o.plugins.colors||{});var e={dropdown:c("foreColor",r)},f={dropdown:c("backColor",r)};r.addBtnDef("foreColor",e),r.addBtnDef("backColor",f)},tagHandler:f}}})}(jQuery);