const express = require("express");
const auth = require("../middleware/auth");
const userRouter = express.Router();

userRouter.get("/api/products/add-to-cart", auth, async (req, res) => {
  try {
    const { id } = req.body;

    let product = await Product.findById(id);

    let user = await User.findById(req.user);

    if (product.quantity == 0)
      return res.status(400).json({ msg: "Product is out of stock" });

    if (user.cart.length == 0) {
      user.cart.push({ product, quantity: 1 });
      product.quantity -= 1;
    }
    //check this
    else {
      let isProductFound = false;
      for (let i = 0; i < user.cart.length; i++) {
        if (user.cart[i].product._id.equals(product._id)) {
          isProductFound = true;
        }
      }
      if (isProductFound) {
        let foundProduct = user.cart.find((i) =>
          i.product._id.equals(product._id)
        );
        foundProduct.quantity += 1;
      } else {
        user.cart.push({ product, quantity: 1 });
      }
    }
    user = await user.save();
    res.json(user);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

module.exports = userRouter;
