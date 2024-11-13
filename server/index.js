//imports
const express = require("express");
const mongoose = require("mongoose");
require("dotenv").config();
const app = express();

const authRouter = require("./routes/auth");

//middleware
app.use(express.json());
app.use(authRouter);

//init

//const mongoPassword = "peterchinokoo"
const port = 3000;
const DB = process.env.MONGODB_URI;

//Connections
//database connection
mongoose
  .connect(DB)
  .then(() => console.log("Database connected"))
  .catch((e) => console.log(e));

//port connection
app.listen(port, "0.0.0.0", () => {
  console.log(`Server running on port ${port}`);
});
