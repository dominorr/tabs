$(document).ready(function(){
	
	$(document).on('change', ".select-chord", function(){
		$('#lyrics-and-chords').append("<input class='sam-hidden' type='hidden' name='tab[chord_positions][]' value='"+$(this).data('chord-position')+"'/>");
	})
	$('#to-add-lyrics').click(function(){
		$('#tab-info').slideUp('fast');
		$('#tab-lyrics').slideDown('fast');

	})
	$('#back-to-tab-info').click(function(){
		$('#tab-lyrics').slideUp('fast');
		$('#tab-info').slideDown('fast');
	})
	$('#back-to-add-lyrics').click(function(){
		$('#tab-chords').slideUp('fast');
		$('#tab-lyrics').slideDown('fast');
	})

	$('.like-button').click(function(){
		$.ajax({
			type: 'POST',
			beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
			dataType: 'json',
			data: { rating: {tab_id: $('.show-tab').data('tab-id'), value: true }},
			url: '/ratings.json',
			success: function(data){
				$('.likes-bar').css('width', data['likes_percentage'] + 'px');
				$('.dislikes-bar').css('width', data['dislikes_percentage'] + 'px');
				$('.number-of-likes').text(data['number_of_likes'])
			}
		})
	})
	$('.dislike-button').click(function(){
		$.ajax({
			type: 'POST',
			beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
			dataType: 'json',
			data: { rating: {tab_id: $('.show-tab').data('tab-id'), value: false }},
			url: '/ratings.json',
			success: function(data){
				$('.likes-bar').css('width', data['likes_percentage'] + 'px');
				$('.number-of-dislikes').text(data['number_of_dislikes'])
				$('.dislikes-bar').css('width', data['dislikes_percentage'] + 'px');
			}
		})
	})

	$('#comment-form').on('ajax:success', function(data){
		console.log(data['content']);
	})

})