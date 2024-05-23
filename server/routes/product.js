const express= require('express');
const productRouter=express.Router();
const Product = require('../models/product');
const auth = require('../middlewares/auth');

// /api/products?category=Essentials
// /api/amazon?theme=dark
// /api/products:category=Essential  params
productRouter.get('/api/products',auth, async(req,res)=>{
    try{
      
    console.log(req.query.category);
      const products=await Product.find({category :req.query.category});
       res.json(products);
    }catch(e){
     res.status(500).json({error:e.message});
    } 
 });

// Create a get request to search products and get them
// /api/products/search/i
productRouter.get('/api/products/search/:name',auth, async(req,res)=>{
   try{
     
   console.log(req.params.name);
     const products=await Product.find({
      name: {$regex:req.params.name, $options:"i"},
     });
     // iphone i
      res.json(products);
   }catch(e){
    res.status(500).json({error:e.message});
   } 
});

// create a post request route  to rate the product
productRouter.post('/api/rate-product', auth, async (req, res) => {
   try {
     const { id, rating } = req.body;
     let product = await Product.findById(id); // Correctly await the promise
 
     if (!product) {
       return res.status(404).json({ error: 'Product not found' });
     }
 
     if (!product.rating) {
       product.rating = [];
     }
 
     const userId = req.user; // Assuming req.user is the user ID
 
     // Check if the user has already rated the product
     const existingRatingIndex = product.rating.findIndex(r => r.userId.toString() === userId);
 
     if (existingRatingIndex !== -1) {
       // Update the existing rating
       product.rating[existingRatingIndex].rating = rating;
     } else {
       // Add a new rating
       product.rating.push({ userId: userId, rating: rating });
     }
 
     product = await product.save(); // Save the product with the updated ratings
     res.json(product);
   } catch (e) {
     res.status(500).json({ error: e.message });
   }
 });
 

module.exports=productRouter;