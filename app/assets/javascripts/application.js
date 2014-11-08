// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require foundation
//= require bootstrap.min
//= require private_pub
//= require_tree .

$(function(){ $(document).foundation(); });

// function checkFirstVisit() {
//   if(document.cookie.indexOf('mycookie')==-1) {
//     // cookie doesn't exist, create it now
//     document.cookie = 'mycookie=1';
//   }
//   else {
//     // not first visit, so alert
//     alert('You refreshed!');
//   }
// }

// window.onbeforeunload = function() { return "You work will be lost."; };

// $(window).bind('beforeunload', function(){

// 	if (document.getElementById("quiz")!=null) {
// 		return window.lastElementClicked = event.target;;
// 	} else {

// 	}
  
// });

// if($('#yourhiddenfield_id').length > 0)
// {
// 	window.onbeforeunload = function() { 	  return "You work will be lost."; };
// }

