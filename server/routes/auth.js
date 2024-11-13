//imports
const express = require("express");
require("dotenv").config();
const bcryptjs = require("bcryptjs");
const jwt = require("jsonwebtoken");
const authRouter = express.Router();
const User = require("../models/user");
const auth = require("../middleware/auth");

// auth Routes
//signup route
authRouter.post("/api/signup", async (req, res) => {
  try {
    const { name, email, password } = req.body;

    //checking if user already exists
    const existingUser = await User.findOne({ email });
    if (existingUser)
      return res
        .status(400)
        .json({ msg: "User with the same email already exists." });
    //hashing password
    const hashedPassword = await bcryptjs.hash(
      password,
      parseInt(process.env.BYCRYPT_SALT)
    );
    //creating new user
    let user = new User({
      email,
      password: hashedPassword,
      name,
    });
    //saving user to mongodb database
    user = await user.save();
    //returning a response with json data of user
    res.json(user);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

//signin route
authRouter.post("/api/signin", async (req, res) => {
  try {
    //checking if user exists
    const user = await User.findOne({ email: req.body.email });

    if (!user) return res.status(400).json({ msg: "User not found" });

    //checking if password is correct
    const correctPassword = await bcryptjs.compare(
      req.body.password,
      user.password
    );
    //if password is incorrect, return error message
    if (!correctPassword)
      return res.status(400).json({ msg: "Incorrect Password" });
    //generating a token
    const token = jwt.sign({ id: user._id }, process.env.JWT_SECRET_KEY);

    res.json({ token, ...user._doc });
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

authRouter.post("/tokenIsValid", async (req, res) => {
  try {
    //getting token from header
    const token = req.header("x-auth-token");
    //checking if token exists
    if (!token) return res.json(false);
    //verifying token if it is valid
    const verified = jwt.verify(token, process.env.JWT_SECRET_KEY);
    //if token is not valid, return false
    if (!verified) return res.json(false);
    //if token is valid, find user by id and return true, since we signed user with id
    const user = await User.findById(verified.id);
    //if user is not found, return false
    if (!user) return res.json(false);
    //if user is found, return true
    res.json(true);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

authRouter.get("/", auth, async (req, res) => {
  //getting user by id in the request
  const user = await User.findById(req.user);
  //returning user data with token
  res.json({ ...user._doc, token: req.token });
});

module.exports = authRouter;
