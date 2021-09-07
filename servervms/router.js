const express = require("express");
const router = express.Router();
const pool = require("./db.js");
const date = require('date-and-time');

//HOME ROUTER
router.get("/", (req, res) => {
  res.send("Server is running");
});


//ADD VISITOR ROUTER
router.post("/addvisitor", async (req, res) => {
  try {
    const { name, adrs, whom, phone } = req.body;
    const newTodo = await pool.query(
      "INSERT INTO visitor (vname,vadrs,vmeet, vphone) VALUES($1,$2,$3,$4) RETURNING *",
      [name, adrs, whom, phone]
    );
    res.json(newTodo.rows[0]);
    console.log(req.body);
  } catch (err) {
    console.error(err.message);
  }
});

//SHOW VISITOR ROUTER
router.get("/showvisitor", async (req, res) => {
  try {
    const { name, adrs, whom, phone} = req.body;
    const newTodo = await pool.query("SELECT * FROM  visitor ORDER BY vid DESC");
    res.json(newTodo.rows);
    console.log(req.body);
  } catch (err) {
    console.error(err.message);
  }
});




module.exports = router;
