module.exports = function(){
  var express = require('express');
  var router = express.Router();

  function getTransactions(res, mysql, context, complete){
    mysql.pool.query('SELECT * FROM transactions', function(err, results, fields){
      if(err){
        next(err);
        return;
      }
      context.transactions = results;
      complete();
    });
  };

  function getTransaction(res, mysql, context, id, complete){
    var sql = 'SELECT id, dealership_ID, car_ID, customer_ID, date FROM transactions WHERE id = '+ id;
    mysql.pool.query(sql, function(err, results, fields){
      if (err){
        next(err);
        return;
      }
      context.transaction = results[0];
      complete();
    });
  };

  router.get('/', function(req, res){
    var mysql = req.app.get('mysql');
    context = {};
    //context.jsscripts = ["deleteTransaction.js"];
    getTransactions(res, mysql, context, complete);
    function complete(){
      res.render('transactions', context);
    }
  });

  router.get('/:id', function(req, res){
    var context = {};
    context.jsscripts = ["updateTransaction.js"];
    var mysql = req.app.get('mysql');
    getTransaction(res, mysql, context, req.params.id, complete);
    function complete(){
      res.render('update_transaction', context);
    }
  });

router.put('/:id', function(req, res){
  var mysql = req.app.get('mysql');
  var sql = "UPDATE transactions SET dealership_ID=?, car_ID=?, customer_ID=? WHERE id=?";
  var insert= [req.body.dealership_ID, req.body.car_ID, req.body.customer_ID, req.params.id];
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
    var sql = "INSERT INTO transactions (dealership_ID, date, car_ID, customer_ID) VALUES ('" + req.body.dealership_ID +"','"+ req.body.date +"','"+ req.body.car_ID +"','"+ req.body.customer_ID + "')";
    sql = mysql.pool.query(sql, function(err, results, fields){
      if (err){
        res.write(JSON.stringify(err));
        res.status(400);
        res.end();
      } else {
        res.redirect('/transactions');
      }
    });
  });


router.delete('/:id', function(req,res){
//    var mysql = req.app.get('mysql');
//    var sql = "DELETE FROM cars WHERE id = " + req.params.id;
//    sql = mysql.pool.query(sql, function(err, results, fields){
      if (err){
        res.write(JSON.stringify(err));
        res.status(400);
        res.end();
      } else {
        res.status(202).end();
      }
    });




  return router;
}();
