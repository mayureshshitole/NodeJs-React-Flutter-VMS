const express = require("express");
const cors = require("cors");
const app = express();
const router = require("./router.js");
require("dotenv").config();
const PORT = process.env.PORT || 5000;
//middlewares
app.use(cors());
app.use(express.json());

//ROUTERS
app.use(router);
//PORT WHERE APP RUNS
app.listen(PORT, () => {
  console.log("server running on " + PORT);
});
