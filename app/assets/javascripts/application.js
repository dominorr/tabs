// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//= require rails-ujs
//= require jquery3
//= require bootstrap.min
//= require_tree .

$(document).ready(function(){
	var fretHeight = 20;
  	var stringWidth = 20;
  	var textOffsetY = -3;

  	var ctx = '';



	function chord(positions, fingering){
		ch = {
    		placement: positions,
    		fingering: fingering,
  		}
  		return ch;
	}

	function removeX(array){
	    var searchTerm = 'x';
	    cleanArray = [];
	    
	    for(n=0; n<=array.length - 1; n++){
	      if(array[n] != searchTerm ){
	        cleanArray.push(parseInt(array[n]));
	      }
	    }
	    return cleanArray;
  	}

  	function drawChord(chord){
	    var offsetY = 0;
	    var offsetX = 0;
	    
	    var maxPos = Math.max.apply(Math, removeX(chord.placement));
	    var minPos = Math.min.apply(Math, removeX(chord.placement));
	    
	    console.log(chord.placement);
	    
	    for(f=minPos; f<=maxPos + 1; f++){
	      ctx.beginPath();
	      
	      if(f == 0){
	        ctx.lineWidth = 4;
	      } else{
	        ctx.lineWidth = 1;
	      }
	      //draw the frets
	      ctx.moveTo(0 + stringWidth, offsetY + fretHeight);
	      ctx.lineTo(100 + stringWidth, offsetY + fretHeight);
	      ctx.strokeStyle = 'gray';
	      ctx.stroke();
	      
	      var offsetY = offsetY + 20;
	    }
	    
	    for(i=0; i<chord.placement.length; i++){    
	      var stringH = (maxPos - minPos + 1) * fretHeight;
	      
	      if(chord.placement[i] == 'x'){
	        var y = fretHeight + textOffsetY;
	      } else{
	        var y = (fretHeight * chord.placement[i]) + fretHeight + textOffsetY;
	      }
	      
	      var x = stringWidth + offsetX - (stringWidth / 4);
	      
	      //draw the strings
	      ctx.beginPath();
	      ctx.fillStyle = 'white';
	      ctx.fillRect(x, y-10, 10, 10);
	      
	      ctx.moveTo(offsetX + stringWidth, 0 + fretHeight);
	      ctx.lineTo(offsetX + stringWidth, stringH + fretHeight);

	      ctx.fillStyle = 'black';
	      ctx.fillText(chord.fingering[i], x, y);

	      ctx.stroke();
	      var offsetX = offsetX + stringWidth;
	    }
	}

	$('.chord').hover(function(){
  		$(this).after("<canvas id='canvas' width='200' height='200'></canvas>");
  		var c = document.getElementById('canvas');
  		ctx = c.getContext('2d');

  		ctx.font = "18px Arial";
  		drawChord(chord($(this).data('positions'), $(this).data('fingering')));
  		$('#canvas').show();
  	},function(){
  		$(this).next().remove();
  	})
})