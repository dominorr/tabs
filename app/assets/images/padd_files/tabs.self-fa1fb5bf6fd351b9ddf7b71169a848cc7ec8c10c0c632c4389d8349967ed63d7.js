$(document).ready(function(){
	$('#submit-lyrics').click(function(){
		var lyrics = $('#the-lyrics').val();
		var lines = lyrics.split('\n');
		var line_number = 1;
		var chord_position = 0;
		lines.forEach(function(line){
			$('.lyrics-and-chords').append("<div id='chord-list"+line_number+"'></div>");
			line.split(' ').forEach(function(word){
				$("#chord-list"+line_number).append("<select class='select-chord' data-chord-position='"+chord_position+"' name='tab[chords][]' style='width:"+word.length*7+"px;'><option disabled selected value> -- select -- </option><option value='C'>C</option><option value='E'>E</option></select>");
				chord_position = chord_position + 1;
			})
			$('.lyrics-and-chords').append("<p>"+line+"</p>");
			line_number = line_number + 1;
		})
	})
	$('#submit-lyrics').hover(function(){
		console.log('facui hover');
	})
	$(document).on('change', ".select-chord", function(){
		$('.lyrics-and-chords').append("<input class='sam-hidden' type='hidden' name='tab[chord_positions][]' value='"+$(this).data('chord-position')+"'/>");
	})

})
