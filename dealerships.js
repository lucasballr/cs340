module.exports = function(){
  var express = require('express');
  var router = express.Router();

  function getDealerships(res, mysql, context, complete){
    mysql.pool.query('SELECT * FROM dealerships', function(err, results, fields){
      if(err){
        res.write(JSON.stringify(err));
        res.end();
      }
      context.dealerships = results;
      complete();
    });
  };

  function getDealership(res, mysql, context, id, complete){
    var sql = 'SELECT id, name, phoneNum, carStock FROM dealerships WHERE id = '+ id;
    mysql.pool.query(sql, function(err, results, fields){
      if (err){
        res.write(JSON.stringify(err));
        res.end();
      }
      context.dealership = results[0];
      complete();
    });
  }

  router.get('/', function(req, res){
    var mysql = req.app.get('mysql');
    context = {};
    context.jsscripts = ["deleteDealership.js"];
    getDealerships(res, mysql, context, complete);
    function complete(){
      res.render('dealerships', context);
    }
  });

  router.get('/:id', function(req, res){
    var context = {};
    context.jsscripts = ["updateDealership.js"];
    var mysql = req.app.get('mysql');
    getDealership(res, mysql, context, req.params.id, complete);
    function complete(){
      res.render('update_dealership', context);
    }
  });

router.put('/:id', function(req, res){
  var mysql = req.app.get('mysql');
  var sql = "UPDATE dealerships SET name=?, phoneNum=?, carStock=? WHERE id=?";
  var insert= [req.body.name, req.body.phoneNum, req.body.carStock, req.params.id];
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
    var sql = "INSERT INTO dealerships (name, phoneNum, carStock) VALUES ('" + req.body.name +"','"+ req.body.phoneNum +"','"+ req.body.carStock + "')";
    sql = mysql.pool.query(sql, function(err, results, fields){
      if (err){
        res.write(JSON.stringify(err));
        res.status(400);
        res.end();
      } else {
        res.redirect('/dealerships');
      }
    });
  });

  router.delete('/:id', function(req,res){
    var mysql = req.app.get('mysql');
    var sql = "DELETE FROM dealerships WHERE id = " + req.params.id;
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
