const express = require("express");
const User = require("../models/user");
const bcryptjs = require("bcryptjs");
const authRouter = express.Router();
const jwt = require("jsonwebtoken");
const auth = require("../middlewares/auth");

authRouter.post("/api/signup", async (req, res) => {
  try {
    const { name, email, password } = req.body;
    // {'name':name, 'email':email,'password':password}
    // _v
    // id
    // get data from client
    // post that data in database
    // return that data to the user
    const existingUser = await User.findOne({ email });
    if (existingUser) {
      return res
        .status(400)
        .json({ msg: "User with same email already exists!" });
    }
    const hashPassword = await bcryptjs.hash(password, 8);
    let user = new User({
      email,
      password: hashPassword,
      name,
    });
    user = await user.save();
    res.json(user);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});
authRouter.post("/api/signin", async (req, res) => {
  try {
    const { email, password } = req.body;
    // equivalent
    // const email = req.body.email;
    // const password = req.body.password;

    const user = await User.findOne({ email });
    if (!user) {
      return res
        .status(400)
        .json({ msg: "User with this email does not exist" });
    }
    // test123 , gibberish  2 same password hashed won't have the same hash cuz of salt
    const isMatch = await bcryptjs.compare(password, user.password);
    if (!isMatch) {
      return res.status(400).json({ msg: "Incorrect password" }); 
    }
    const token = jwt.sign({ id: user._id }, "passwordKey");
    res.json({ token, ...user._doc });
    // {
    //   'name':'Shadan',
    //   'email':'aoj@gmail.com'
    // }
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

authRouter.post("/tokenIsValid", async (req, res) => {
  try {
    const token = req.header("x-auth-token");
    if (!token) return res.json(false);
    const verified = jwt.verify(token, "passwordKey");
    if (!verified) return res.json(false);
    const user = await User.findById(verified.id);
    if (!user) return res.json(false);
    res.json(true);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

authRouter.get("/", auth, async (req, res) => {
  const user = await User.findById(req.user);
  res.json({ ...user._doc, token: req.token });
});

module.exports = authRouter;
// in case you  want to export multiple things you need to create object use {othermodule:sdfh, jsdofi:"fhoasdh"}
