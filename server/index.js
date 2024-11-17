//imports
const express = require("express");
const mongoose = require("mongoose");
const multer = require("multer");
require("dotenv").config();
const app = express();

const authRouter = require("./routes/auth");
const productRouter = require("./routes/product");

//configuring multer for file storage.
const Storage = multer.diskStorage({
  // Define where uploaded files will be saved - in 'image_uploads' folder
  destination: function (req, file, cb) {
    cb(null, "image_uploads/");
  },
  // Define how filenames will be generated - using timestamp + original file extension
  filename: function (req, file, cb) {
    cb(null, Date.now() + Path2D.extname(file.originalname));
  },
});

// Create multer upload instance with our storage configuration
const upload = multer({ storage: Storage });

//middleware
app.use(express.json());
app.use("/uploads", express.static("uploads"));
app.use(authRouter);
app.use(productRouter);
app.use(upload.array("image", 4));

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

module.exports = { upload };
