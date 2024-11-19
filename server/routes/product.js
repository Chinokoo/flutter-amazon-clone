const express = require("express");
productRouter = express.Router();
const Product = require("../models/product");
const admin = require("../middleware/admin");
const multer = require("multer");
const path = require("path");
//const { upload } = require("../index");

const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, "uploads/");
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
      });
      //saving the product to the db
      const savedProduct = await product.save();

      res.json(savedProduct);
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  }
);

//getting the products
productRouter.get("/admin/products", admin, async (req, res) => {
  try {
    const products = await Product.find({ id: req.header.id });
    res.json(products);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

//deleting a  product
productRouter.post("/admin/delete-product", admin, async (req, res) => {
  try {
    const { id } = req.body;
    let product = await Product.findByIdAndDelete(id);
    res.json(product);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});
module.exports = productRouter;
