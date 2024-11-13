const jwt = require("jsonwebtoken");

const auth = async (req, res, next) => {
  try {
    // Get token from header
    const token = req.header("x-auth-token");
    //if token is not available return unauthorized error!
    if (!token) return res.status(401).json({ msg: "No token, access denied" });

    //verify token
    const verified = jwt.verify(token, process.env.JWT_SECRET_KEY); //JWT_SECRET_KEY
    if (!verified)
      return res.status(401).json({ msg: "Invalid token, access denied" });

    req.user = verified.id; //add user id to request object
    req.token = token;
    //proceed to next middleware
    next();
  } catch (error) {
    return res.status(500).json({ error: error.message });
  }
};

module.exports = auth;
