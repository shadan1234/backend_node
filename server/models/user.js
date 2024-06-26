const mongoose = require("mongoose");
const { use } = require("../routes/auth");
const { productSchema } = require("./product");

const userSchema = mongoose.Schema({
  name: {
    required: true,
    type: String, // mongoose understand string not js
    trim: true,
  },
  email: {
    required: true,
    type: String,
    trim: true,
    validate: {
      validator: (value) => {
        const re = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
        return value.match(re);
      },
      message: "Please enter a valid email address",
    },
  },
  password: {
    required: true,
    type: String,
    trim:true,
    validate: {
        validator: (value) => {
         
          return value.length>6;
        },
        message: "Please enter a valid password",
      },
  },
  address: {
    type: String,
    default: "",
  },
  type: {
    type: String,
    default: "user",
  },
  //cart
  cart:[
     {
      product: productSchema,
      quantity:{
        type:Number,
        required:true
      }
     }
  ]
});

const User=mongoose.model('User',userSchema);
// Creates a model
module.exports=User;