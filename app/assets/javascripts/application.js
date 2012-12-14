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
//= require jquery-ui
//= require_tree .

    $(function () {
        var tabContainers = $('div.tabs > div');
        tabContainers.hide().filter(':first').show();
        $('div.tabs ul.tabNavigation a').click(function () {
            tabContainers.hide();
            tabContainers.filter(this.hash).show();
            $('div.tabs ul.tabNavigation a').removeClass('active-tab').addClass('tab');
            $(this).addClass('active-tab').removeClass('tab');
            return false;
        }).filter(':first').click();
    });

    $(function(){
        $(".rightSpan").hide();
        $("h3 span.expand").click(
        function(){
            $(this).parent().next().slideToggle();
	       });
	   });

    $(function() {
           $('#slider-code').tinycarousel({display: 1});
           $('#slider-code2').tinycarousel({display: 1});
    });

    $(function() {
           var sliders = $('#slider-code2');
           $('.image-slider-size').click(
               function() {
                   var id = $(this).attr("rel");
                   sliders.tinycarousel_move(id);
                   $('.image-slider-size').removeClass("active-slider");
                   $(this).addClass("active-slider");
               }
           );
    });

    $(function() {
        $('.next2').click(
            function() {
                   var pos = $('.active-slider').attr("rel");
                   $('.image-slider-size').removeClass("active-slider");
                   var mass = $('.image-slider-size');
                   $(mass[pos]).addClass("active-slider");
                   if ($('.next1').hasClass('disable') == false) {
                       $('.next1').click();
                   }
               }
        );
    });

    $(function() {
        $('.prev2').click(
            function() {
                   var pos = $('.active-slider').attr("rel");
                   $('.image-slider-size').removeClass("active-slider");
                   var mass = $('.image-slider-size');
                   $(mass[pos-2]).addClass("active-slider");
                   if ($('.prev1').hasClass('disable') == false) {
                       $('.prev1').click();
                   }
               }
        );
    });

    $(function() {
           $('body').on('click.popover.data-api',function() {
               $('a#tab-alert').popover('hide');
           });

           $('a#tab-alert').popover({
               html: 'true',
               content: $('#content').html(),
               placement: 'bottom',
               trigger: 'manual'
           }).click(function(e) {
               e.stopPropagation();
               $(this).popover('show');
           });


           $("html").niceScroll();
           $("#scroll-tab").niceScroll();
           $(".tabs .tabNavigation li a").click(function() {
               $("#scroll-tab").getNiceScroll().onResize();
           });
    });