const express = require("express");
productRouter = express.Router();
const Product = require("../models/product");
const admin = require("../middleware/admin");
const multer = require("multer");
const path = require("path");
//const { upload } = require("../index");

const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, "image_uploads/");
  },
  filename: function (req, file, cb) {
    cb(null, Date.now() + path.extname(file.originalname));
  },
});

const upload = multer({ storage: storage });

//adding a router to the db
productRouter.post(
  "/admin/add-product",
  admin,
  upload.array("images", 7),
  async (req, res) => {
    try {
      //getting the files from the request
      const files = req.files;

      const seller = req.header("x-auth-token");

      const fileUrls = files.map(
        (file) =>
          `${req.protocol}://${req.get("host")}/uploads/${file.filename}`
      );
      //creating a new product object
      const product = new Product({
        name: req.body.name,
        description: req.body.description,
        price: req.body.price,
        quantity: req.body.quantity,
        category: req.body.category,
        images: fileUrls,
        seller: seller.name,
      });
      //saving the product to the db
      const savedProduct = await product.save();

      res.json(savedProduct);
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  }
);

module.exports = productRouter;
