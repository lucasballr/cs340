var express = require('express');
var mysql = require('./dbcon.js');
var bodyParser = require('body-parser');

var app = express();
var handlebars = require('express-handlebars').create({defaultLayout:'main'});

app.engine('handlebars', handlebars.engine);
app.use(bodyParser.urlencoded({extended:true}));
app.set('view engine', 'handlebars');
app.set('port', 5558);
app.set('mysql', mysql);
app.use('/static', express.static('public'));

app.get('/',function(req,res){
  res.render('home');
});

app.use('/cars', require('./cars.js'));

app.use('/employees', require('./employees.js'));

app.use('/dealerships', require('./dealerships.js'));

app.use('/transactions', require('./transactions.js'));

app.use('/customers', require('./customers.js'));

/*
var wrapper = document.getElementById('deleteButton');
wrapper.addEventListener('click', (event) => {
  var isButton = event.target.nodeName === 'BUTTON';
  if (!isButton) {
    return;
  }
  console.log(event.target.id);
});
*/
function genContext(){
  var stuffToDisplay = {};
  stuffToDisplay.time = (new Date(Date.now())).toLocaleTimeString('en-US');
  return stuffToDisplay;
}

app.get('/time',function(req,res){
  res.render('time', genContext());
});

app.use(function(req,res){
  res.status(404);
  res.render('404');
});

app.use(function(err, req, res, next){
  console.error(err.stack);
  res.type('plain/text');
  res.status(500);
  res.render('500');
});

app.listen(app.get('port'), function(){
  console.log('Express started on http://localhost:' + app.get('port') + '; press Ctrl-C to terminate.');
});
