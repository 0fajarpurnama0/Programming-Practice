const mysql = require('mysql2/promise');

const dbConfig = {
  host: 'localhost',
  user: 'flutter_latihan_arsip_barang',
  password: 'flutter_latihan_arsip_barang',
  database: 'flutter_latihan_arsip_barang'
};

const db = mysql.createPool(dbConfig);

module.exports = db;