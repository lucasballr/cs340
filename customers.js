module.exports = function(){
  var express = require('express');
  var router = express.Router();

  function getCustomers(res, mysql, context, complete){
    mysql.pool.query('SELECT * FROM customers', function(err, results, fields){
      if(err){
        res.write(JSON.stringify(err));
        res.end();
      }
      context.customers = results;
      complete();
    });
  };

  function getCustomer(res, mysql, context, id, complete){
    var sql = 'SELECT id, fName, lName FROM customers WHERE id = '+ id;
    mysql.pool.query(sql, function(err, results, fields){
      if (err){
        res.write(JSON.stringify(err));
        res.end();
      }
      context.customer = results[0];
      complete();
    });
  }

  router.get('/', function(req, res){
    var mysql = req.app.get('mysql');
    context = {};
    context.jsscripts = ["deleteCustomer.js"];
    getCustomers(res, mysql, context, complete);
    function complete(){
      res.render('customers', context);
    }
  });

  router.get('/:id', function(req, res){
    var context = {};
    context.jsscripts = ["updateCustomer.js"];
    var mysql = req.app.get('mysql');
    getCustomer(res, mysql, context, req.params.id, complete);
    function complete(){
      res.render('update_customer', context);
    }
  });

router.put('/:id', function(req, res){
  var mysql = req.app.get('mysql');
  var sql = "UPDATE customers SET fName=?, lName=? WHERE id=?";
  var insert= [req.body.fName, req.body.lName, req.params.id];
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
    var sql = "INSERT INTO customers (fName, lName) VALUES ('" + req.body.fName +"','"+ req.body.lName + "')";
    sql = mysql.pool.query(sql, function(err, results, fields){
      if (err){
        res.write(JSON.stringify(err));
        res.status(400);
        res.end();
      } else {
        res.redirect('/customers');
      }
    });
  });

  router.delete('/:id', function(req,res){
    var mysql = req.app.get('mysql');
    var sql = "DELETE FROM customers WHERE id = " + req.params.id;
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
