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

$(document).ready(function(){
	$("input[name='pay-radio']").click(function(){
		$('#a-pay').css('display',($(this).val() == '1')? 'block':'none');
		$('#c-pay').css('display',($(this).val() == '2')? 'block':'none');
	});
})