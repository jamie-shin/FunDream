$(document).ready(function(){
	 $('body').addClass('js');
		$.fn.accordion = function(){
			$(this).each(function(){
				var a = $(this);
				a.find('dt').click(function(e){
					if($(this).hasClass('open')){
						$(this).removeClass('open');
					}else{
						$(this).addClass('open');
					}
					e.preventDefault();
					return false;
				}).first().addClass('open');
			});
		};
	  $('.accordion').accordion();
});