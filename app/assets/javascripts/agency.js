/*!
 * Start Bootstrap - Agency Bootstrap Theme (http://startbootstrap.com)
 * Code licensed under the Apache License v2.0.
 * For details, see http://www.apache.org/licenses/LICENSE-2.0.
 */

// jQuery for page scrolling feature - requires jQuery Easing plugin
$(function() {
    $('a.page-scroll').bind('click', function(event) {
        var $anchor = $(this);
      /*!
      *  $('html, body').stop().animate({
      *      scrollTop: $($anchor.attr('href')).offset().top
      *  }, 1500, 'easeInOutExpo');
      */
        // get target div to scroll to
		var target = $($anchor.attr('href'));
		// if target is valid, scroll to
		if(target && target.offset()){
	    $('html, body').stop().animate({
        scrollTop: target.offset().top
    	}, 850,'easeInOutExpo');
		}
        
        event.preventDefault();
    });
});

// Highlight the top nav as scrolling occurs
$('body').scrollspy({
    target: '.navbar-fixed-top'
});

// Closes the Responsive Menu on Menu Item Click
$('.navbar-collapse ul li a').click(function() {
    $('.navbar-toggle:visible').click();
});


$(document).ready(function(){
    $('[data-toggle="tooltip"]').tooltip();
});


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



