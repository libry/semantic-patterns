/*!
 * Start Bootstrap - Agency Bootstrap Theme (http://startbootstrap.com)
 * Code licensed under the Apache License v2.0.
 * For details, see http://www.apache.org/licenses/LICENSE-2.0.
 */

// jQuery for page scrolling feature - requires jQuery Easing plugin
$(function() {
    $('a.page-scroll').bind('click', function(event) {
        var $anchor = $(this);
        $('html, body').stop().animate({
            scrollTop: $($anchor.attr('href')).offset().top
        }, 1500, 'easeInOutExpo');
        event.preventDefault();
    });
});

// Highlight the top nav as scrolling occurs
$('body').scrollspy({
    target: '.navbar-fixed-top'
})

// Closes the Responsive Menu on Menu Item Click
$('.navbar-collapse ul li a').click(function() {
    $('.navbar-toggle:visible').click();
});


// Open Tooltips by hover the questionmark netx to search categories - manuell hingefügt
$(document).ready(function(){
    $('[data-toggle="tooltip"]').tooltip();
});


// Fade In the section by scrolling down - manuell hinzugefügt
$(document).ready(function(){
  
 
    $(window).scroll(function(){
    
     
       $('.hideme').each(function(i){
            
       
           var bottom_of_object = $(this).offset().top + $(this).outerHeight();
            var bottom_of_window = $(window).scrollTop() + $(window).height();
            
            
           if( bottom_of_window > bottom_of_object ){
                
                $(this).animate({'opacity':'1'},1000);
                    
            }
            
        
       }); 
    
   });
  });


$(document).ready(function(){
    $(".searchgo").click(function(){
        $(".noresults").fadeOut()
    });
  
});
