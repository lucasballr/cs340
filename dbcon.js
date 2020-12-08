var mysql = require('mysql');
var pool = mysql.createPool({
  connectionLimit : 10,
  host            : 'classmysql.engr.oregonstate.edu',
  user            : 'cs340_balll',
  password        : 'MY#hmnil1',
  database        : 'cs340_balll'
});

module.exports.pool = pool;
