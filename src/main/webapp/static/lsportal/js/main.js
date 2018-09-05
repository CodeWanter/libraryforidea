jQuery(document).ready(function($){
	var $form_modal = $('.cd-user-modal'),
		$form_login = $form_modal.find('#cd-login'),
		$form_modal_tab = $('.cd-switcher'),
		$tab_login = $form_modal_tab.children('li').eq(0).children('a'),
		$main_nav = $('.main_nav');

	$main_nav.on('click', function(event){
		if( $(event.target).is($main_nav) ) {
			$(this).children('ul').toggleClass('is-visible');
		} else {
			if($(event.target).is($("#userlogin"))){
                $main_nav.children('ul').removeClass('is-visible');
                $form_modal.addClass('is-visible');
                login_selected();
			}
		}
	});

	$('.cd-user-modal').on('click', function(event){
		if( $(event.target).is($form_modal) || $(event.target).is('.cd-close-form') ) {
			$form_modal.removeClass('is-visible');
		}	
	});
	$(document).keyup(function(event){
    	if(event.which=='27'){
    		$form_modal.removeClass('is-visible');
	    }
    });

	function login_selected(){
		$form_login.addClass('is-selected');
		$tab_login.addClass('selected');
	}
});


jQuery.fn.putCursorAtEnd = function() {
	return this.each(function() {
    	if (this.setSelectionRange) {
      		var len = $(this).val().length * 2;
      		this.setSelectionRange(len, len);
    	} else {
      		$(this).val($(this).val());
    	}
	});
};