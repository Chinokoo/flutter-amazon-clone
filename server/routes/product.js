const express = require("express");
productRouter = express.Router();
const { Product } = require("../models/product");
const auth = require("../middleware/auth");
const admin = require("../middleware/admin");
const multer = require("multer");
const path = require("path");

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
productRouter.delete("/admin/delete-product", admin, async (req, res) => {
  try {
    const { id } = req.body;
    const product = await Product.findByIdAndDelete(id);
    res.json(product);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

//get  products by category
productRouter.get("/api/products", auth, async (req, res) => {
  try {
    const products = await Product.find({ category: req.query.category });
    if (!products) res.status(400).json({ msg: "Category not found" });

    res.json(products);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

//get the searched products
productRouter.get("/api/products/search/:name", auth, async (req, res) => {
  try {
    const products = await Product.find({
      name: { $regex: req.params.name, $options: "i" },
    });
    if (!products) res.status(400).json({ msg: "product is not available" });
    res.json(products);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

//create the post request to add the product rating
productRouter.post("/api/rate-product", auth, async (req, res) => {
  try {
    const { id, rating } = req.body;
    let product = await Product.findById(id);
    for (let i = 0; i < product.ratings.length; i++) {
      if (product.ratings[i].userId == req.user) {
        product.ratings.splice(i, 1);
        break;
      }
    }
    const ratingSchema = {
      userId: req.user,
      rating,
    };
    product.ratings.push(ratingSchema);
    product = await product.save();
    res.json(product);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

//getting the deal of the day product.
productRouter.get("/api/products/deal-of-day", auth, async (req, res) => {
  try {
    let products = await Product.find({});
    products = products.sort((a, b) => {
      let aSum = 0; // Initialize sum for product a's ratings
      let bSum = 0; // Initialize sum for product b's ratings

      // Calculate sum of all ratings for product a
      for (let i = 0; i < a.ratings.length; i++) {
        aSum += a.ratings[i].rating;
      }

      // Calculate sum of all ratings for product b
      for (let i = 0; i < b.ratings.length; i++) {
        bSum += b.ratings[i].rating; // Fixed: Changed aSum to bSum here
      }

      return aSum < bSum ? 1 : -1;
    });
    res.json(products[0]);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

module.exports = productRouter;
