module.exports = function(){
  var express = require('express');
  var router = express.Router();

  function getCars(res, mysql, context, complete){
    mysql.pool.query('SELECT * FROM cars', function(err, results, fields){
      if(err){
        next(err);
        return;
      }
      context.cars = results;
      complete();
    });
  };

  function getCar(res, mysql, context, id, complete){
    var sql = 'SELECT id, make, model, year, price FROM cars WHERE id = '+ id;
    mysql.pool.query(sql, function(err, results, fields){
      if (err){
        next(err);
        return;
      }
      context.car = results[0];
      complete();
    });
  }

  router.get('/', function(req, res){
    var mysql = req.app.get('mysql');
    context = {};
    context.jsscripts = ["deleteCar.js"];
    getCars(res, mysql, context, complete);
    function complete(){
      res.render('cars', context);
    }
  });

  router.get('/:id', function(req, res){
    var context = {};
    context.jsscripts = ["updateCar.js"];
    var mysql = req.app.get('mysql');
    getCar(res, mysql, context, req.params.id, complete);
    function complete(){
      res.render('update_car', context);
    }
  });

router.put('/:id', function(req, res){
  var mysql = req.app.get('mysql');
  var sql = "UPDATE cars SET make=?, model=?, year=?, price=? WHERE id=?";
  var insert= [req.body.make, req.body.model, req.body.year, req.body.price, req.params.id];
  sql = mysql.pool.query(sql, insert, function(err, results, fields){
    if (err){
      res.write(JSON.stringify(err));
      res.end();
    } else {
      res.status(200);
      res.end();
    }
  });
});

  router.post('/', function(req, res){
    var mysql = req.app.get('mysql');
    var sql = "INSERT INTO cars (make, model, year, price) VALUES ('" + req.body.cMake +"','"+ req.body.cModel +"','"+ req.body.cYear +"','"+ req.body.cPrice + "')";
    sql = mysql.pool.query(sql, function(err, results, fields){
      if (err){
        res.write(JSON.stringify(err));
        res.status(400);
        res.end();
      } else {
        res.redirect('/cars');
      }
    });
  });

  router.delete('/:id', function(req,res){
    var mysql = req.app.get('mysql');
    var sql = "DELETE FROM cars WHERE id = " + req.params.id;
    sql = mysql.pool.query(sql, function(err, results, fields){
      if (err){
        res.write(JSON.stringify(err));
        res.status(400);
        res.end();
      } else {
        res.status(202).end();
      }
    });
  });




  return router;
}();