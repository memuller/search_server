// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(function(){
	$('#documents_search').submit(function(){
		$.get(this.action, $(this).serialize(), null, 'script');
		return false;
	});
});