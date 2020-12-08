module.exports = function(){
  var express = require('express');
  var router = express.Router();

  function getEmployees(res, mysql, context, complete){
    mysql.pool.query('SELECT * FROM employees', function(err, results, fields){
      if(err){
        res.write(JSON.stringify(err));
        res.end();
      }
      context.employees = results;
      complete();
    });
  };

  function getEmployee(res, mysql, context, id, complete){
    var sql = 'SELECT id, fname, lname, dealership_ID, type FROM employees WHERE id = '+ id;
    mysql.pool.query(sql, function(err, results, fields){
      if (err){
        res.write(JSON.stringify(err));
        res.end();
      }
      context.employee = results[0];
      complete();
    });
  }

  router.get('/', function(req, res){
    var mysql = req.app.get('mysql');
    context = {};
    context.jsscripts = ["deleteEmployee.js"];
    getEmployees(res, mysql, context, complete);
    function complete(){
      res.render('employees', context);
    }
  });

  router.get('/:id', function(req, res){
    var context = {};
    context.jsscripts = ["updateEmployee.js"];
    var mysql = req.app.get('mysql');
    getEmployee(res, mysql, context, req.params.id, complete);
    function complete(){
      res.render('update_employee', context);
    }
  });

router.put('/:id', function(req, res){
  var mysql = req.app.get('mysql');
  var sql = "UPDATE employees SET fName=?, lName=?, dealership_ID=?, type=? WHERE id=?";
  var insert= [req.body.fname, req.body.lname, req.body.dealership_ID, req.body.type, req.params.id];
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
    var sql = "INSERT INTO employees (fName, lName, dealership_ID, type) VALUES ('" + req.body.fName +"','"+ req.body.lName +"','"+ req.body.dealership_ID +"','"+ req.body.type + "')";
    sql = mysql.pool.query(sql, function(err, results, fields){
      if (err){
        res.write(JSON.stringify(err));
        res.status(400);
        res.end();
      } else {
        res.redirect('/employees');
      }
    });
  });

  router.delete('/:id', function(req,res){
    var mysql = req.app.get('mysql');
    var sql = "DELETE FROM employees WHERE id = " + req.params.id;
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
