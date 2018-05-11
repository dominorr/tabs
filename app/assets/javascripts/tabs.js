$(document).ready(function(){
	$('#to-add-chords').click(function(){
		$('#tab-lyrics').slideUp('fast');
		var lyrics = $('#the-lyrics').val();
		var lines = lyrics.split('\n');
		var line_number = 1;
		var chord_position = 0;
		lines.forEach(function(line){
			$('#lyrics-and-chords').append("<div id='chord-list"+line_number+"'></div>");
			line.split(' ').forEach(function(word){
				$("#chord-list"+line_number).append("<select class='select-chord' data-chord-position='"+chord_position+"' name='tab[chords][]' style='width:"+(word.length*10+20)+"px;'><option disabled selected value> -- select -- </option><option value='C'>C</option><option value='E'>E</option></select>");
				chord_position = chord_position + 1;
			})
			$('#lyrics-and-chords').append("<p style='font-size:17px;word-spacing:20px;'>"+line+"</p>");
			line_number = line_number + 1;
		})
		$('#tab-chords').slideDown('fast');
	})
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

	function createRating(event, data){
		console.log(data['like-rating']);
		console.log(data['dislike-rating']);
	}

	$("create-rating").on('ajax:success', createRating());
	

})