const express= require('express');
const adminRouter=express.Router();
const admin=require('../middlewares/admin');
const {Product} = require('../models/product');

// Creating an Admin Middleware

// Add product


adminRouter.post('/admin/add-product',admin,async(req,res)=>{
    
    try {
        // console.log(req);
        const {name,description,images,quantity,price,category}=req.body;
        // console.log(category);
        let product=new Product({
            name,
            description,
            images, 
            quantity,
            price,
            category
        });
        product=await product.save();
        res.json(product);
         // mongo db gives us our product but also add _id and __version
        //  console.log(product);
    } catch (e) {
        res.status(500).json({error:e.message});
    }
     
})

// Get all your products
// admin/get-products
adminRouter.get('/admin/get-products',admin, async(req,res)=>{
   try{
     // _id and description or any othere attribute can be used to filter out docs
      const products=await Product.find({});
      res.json(products);
   }catch(e){
    res.status(500).json({error:e.message});
   } 
});

// Delete the product
adminRouter.post('/admin/delete-product',admin,async(req,res)=>{
    try {
        const {id}=req.body;
        let product=await Product.findByIdAndDelete(id);
       
        res.json(product);

    } catch (e) {
        res.status(500).json({error:e.message});
    }
});


module.exports=adminRouter;