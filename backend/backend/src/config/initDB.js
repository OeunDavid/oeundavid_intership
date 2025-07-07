// src/config/initDB.js
const sql = require("mssql");
require("dotenv").config();

const config = {
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  server: process.env.DB_SERVER,
  database: "ProductsDB",
  port: parseInt(process.env.DB_PORT),
  options: {
    encrypt: true,
    trustServerCertificate: true,
    enableArithAbort: true,
  },
};

let pool;

async function connectToDatabase() {
  try {
    pool = await sql.connect(config);
    console.log("✅ Connected to SQL Server");
  } catch (err) {
    console.error("❌ Database connection failed:", err.message);
    throw err;
  }
}

function getPool() {
  if (!pool)
    throw new Error("❌ DB not connected. Call connectToDatabase() first.");
  return pool;
}

module.exports = { connectToDatabase, getPool };
