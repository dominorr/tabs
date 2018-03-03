$(document).ready(function(){
var fretHeight = 20;
var stringWidth = 20;
var textOffsetY = -3;

var chord = {
  placement: ['x', 3, 2, 2, 1, 0],
  fingering: ['x', 4, 3, 2, 1, 0],
};

var c = document.getElementById('canvas');
var ctx = c.getContext('2d');

ctx.font = "18px Arial";

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

drawChord(chord);

})