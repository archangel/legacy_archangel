!function(e){"use strict";function t(){var e,t=null;return window.getSelection?(e=window.getSelection(),e.rangeCount&&(t=e.getRangeAt(0).commonAncestorContainer,1!==t.nodeType&&(t=t.parentNode))):(e=document.selection)&&"Control"!==e.type&&(t=e.createRange().parentElement()),t}function n(e){var t=document.createElement("DIV");return t.innerHTML=e,t.textContent||t.innerText||""}function r(){var t=null;if(document.selection)t=document.selection.createRange().parentElement();else{var n=window.getSelection();n.rangeCount>0&&(t=n.getRangeAt(0).startContainer.parentNode)}var r=e(t).contents().closest("pre").length,o=e(t).contents().closest("code").length;r&&o?e(t).contents().unwrap("code").unwrap("pre"):r?e(t).contents().unwrap("pre"):o&&e(t).contents().unwrap("code")}e.extend(!0,e.trumbowyg,{langs:{en:{preformatted:"Code sample <pre>"},fr:{preformatted:"Exemple de code"},it:{preformatted:"Codice <pre>"},zh_cn:{preformatted:"代码示例 <pre>"}},plugins:{preformatted:{init:function(e){var o={fn:function(){e.saveRange();var o=e.getRangeText();if(""!==o.replace(/\s/g,""))try{var a=t().tagName.toLowerCase();if("code"===a||"pre"===a)return r();e.execCmd("insertHTML","<pre><code>"+n(o)+"</code></pre>")}catch(c){}},tag:"pre"};e.addBtnDef("preformatted",o)}}}})}(jQuery);