<a href = "javascript:(function(){
var renj = prompt('enter min,max range of issues to subscribe: ', 'min max');
var min = parseInt(renj.split(" ")[0])
var max = parseInt(renj.split(" ")[1])
for (var i=min;i<=max;i+=1) { var st = 'https://github.com/m8apps/8lt/issues/' + i + '/subscribe'; console.log('subscribing to issue ' + st); $.post(st);}})()" Subscribe</a>

