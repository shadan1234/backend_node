console.log("hello world");
// print('Hello Worl');

// IMPORTS from Packages
// import 'package:express/express.dart'
const express = require("express");
const mongoose=require("mongoose");
// Imports from files
// ./ tells from here where we are in the directory from there we need to go to routes folder then inside it in auth file
const authRouter = require("./routes/auth");
const adminRouter = require("./routes/admin");
const productRouter = require("./routes/product");
const userRouter = require("./routes/user");

// INIT 
const PORT = 3000; // convention to use 3000 can be any no.

const app = express(); // express initialization
const DB="mongodb+srv://shadan:abcdefg@cluster0.zfqxkem.mongodb.net/?retryWrites=true&w=majority";

// middleware ->helps to set format
// it matches payload the below line
app.use(express.json());
app.use(authRouter);
app.use(adminRouter);
app.use(productRouter);
app.use(userRouter);


// //Creating an api
// // http://<youripaddress>/hello-world
// app.get('/',(req,res)=>{
//     res.send({name:'Shadan Hussain'});
// })

// app.get('/Hello-World',(req,res)=>{
//     // res.send('Hello World');
// res.json({name:'shada'})
    
// })

// GET, PUT , POST , DELETE,UPDATE ->CRUD

// Connections
 mongoose.connect(DB).then(()=>{
    console.log("Successfully connected");
 })
 .catch((e)=>{console.log(e);})


app.listen(PORT,"0.0.0.0", () => {
  console.log(`connected at port ${PORT} hello`);
});

//127.0.0.1
