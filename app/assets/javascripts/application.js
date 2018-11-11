// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .
$(function(){
  $('.button-checkbox').each(function(){
    var $widget = $(this),
    $button = $widget.find('button'),
    $checkbox = $widget.find('input:checkbox'),
    color = $button.data('color'),
    settings = {
      on: {
        icon: 'glyphicon glyphicon-check'
      },
      off: {
        icon: 'glyphicon glyphicon-unchecked'
      }
    };

    $button.on('click', function () {
      $checkbox.prop('checked', !$checkbox.is(':checked'));
      $checkbox.triggerHandler('change');
      updateDisplay();
    });

    $checkbox.on('change', function () {
      updateDisplay();
    });

    function updateDisplay() {
      var isChecked = $checkbox.is(':checked');
      // Set the button's state
      $button.data('state', (isChecked) ? "on" : "off");

      // Set the button's icon
      $button.find('.state-icon')
      .removeClass()
      .addClass('state-icon ' + settings[$button.data('state')].icon);

      // Update the button's color
      if (isChecked) {
        $button
        .removeClass('btn-default')
        .addClass('btn-' + color + ' active');
      }
      else
      {
        $button
        .removeClass('btn-' + color + ' active')
        .addClass('btn-default');
      }
    }
    function init() {
      updateDisplay();
      // Inject the icon if applicable
      if ($button.find('.state-icon').length == 0) {
        $button.prepend('<i class="state-icon ' + settings[$button.data('state')].icon + '"></i> ');
      }
    }
    init();
  });
});
$.fn.pageMe = function(opts){
  var $this = this,
  defaults = {
    perPage: 7,
    showPrevNext: false,
    hidePageNumbers: false
  },
  settings = $.extend(defaults, opts);

  var listElement = $this;
  var perPage = settings.perPage;
  var children = listElement.children();
  var pager = $('.pager');

  if (typeof settings.childSelector!="undefined") {
    children = listElement.find(settings.childSelector);
  }

  if (typeof settings.pagerSelector!="undefined") {
    pager = $(settings.pagerSelector);
  }

  var numItems = children.size();
  var numPages = Math.ceil(numItems/perPage);

  pager.data("curr",0);

  if (settings.showPrevNext){
    $('<li><a href="#" class="prev_link">«</a></li>').appendTo(pager);
  }

  var curr = 0;
  while(numPages > curr && (settings.hidePageNumbers==false)){
    $('<li><a href="#" class="page_link">'+(curr+1)+'</a></li>').appendTo(pager);
    curr++;
  }

  if (settings.showPrevNext){
    $('<li><a href="#" class="next_link">»</a></li>').appendTo(pager);
  }

  pager.find('.page_link:first').addClass('active');
  pager.find('.prev_link').hide();
  if (numPages<=1) {
    pager.find('.next_link').hide();
  }
  pager.children().eq(1).addClass("active");

  children.hide();
  children.slice(0, perPage).show();

  pager.find('li .page_link').click(function(){
    var clickedPage = $(this).html().valueOf()-1;
    goTo(clickedPage,perPage);
    return false;
  });
  pager.find('li .prev_link').click(function(){
    previous();
    return false;
  });
  pager.find('li .next_link').click(function(){
    next();
    return false;
  });

  function previous(){
    var goToPage = parseInt(pager.data("curr")) - 1;
    goTo(goToPage);
  }

  function next(){
    goToPage = parseInt(pager.data("curr")) + 1;
    goTo(goToPage);
  }

  function goTo(page){
    var startAt = page * perPage,
    endOn = startAt + perPage;

    children.css('display','none').slice(startAt, endOn).show();

    if (page>=1) {
      pager.find('.prev_link').show();
    }
    else {
      pager.find('.prev_link').hide();
    }

    if (page<(numPages-1)) {
      pager.find('.next_link').show();
    }
    else {
      pager.find('.next_link').hide();
    }

    pager.data("curr",page);
    pager.children().removeClass("active");
    pager.children().eq(page+1).addClass("active");

  }
};

$(document).ready(function(){

  $('#myTable').pageMe({pagerSelector:'#myPager',showPrevNext:true,hidePageNumbers:false,perPage:4});

});
function checkAll(check_all){
// Pass in a named "Check All" checkbox that appears on the same form where all
// checkboxes should be checked.

// Loop through an array containing ALL inputs on same form as check_all
var inputs = check_all.form.getElementsByTagName("input");
for (var i = 0; i < inputs.length; i++) {
// Only work on checkboxes, and NOT on the "Check All" checkbox
if (inputs[i].type == "checkbox" && inputs[i].name != check_all.name) {
if(check_all.checked == true){
inputs[i].checked = true ;
}else{
inputs[i].checked = false ;
}
}
}
}
