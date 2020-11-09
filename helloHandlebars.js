var express = require('express');

var app = express();
var handlebars = require('express-handlebars').create({defaultLayout:'main'});

app.engine('handlebars', handlebars.engine);
app.set('view engine', 'handlebars');
app.set('port', 5558);

app.get('/',function(req,res){
  res.render('home');
});

app.get('/cars',function(req,res){
  res.render('cars');
});
app.get('/employees',function(req,res){
  res.render('employees');
});
app.get('/dealerships',function(req,res){
  res.render('dealerships');
});
app.get('/transactions',function(req,res){
  res.render('transactions');
});
app.get('/customers',function(req,res){
  res.render('customers');
});

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
