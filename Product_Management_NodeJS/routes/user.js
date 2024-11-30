const express = require('express');
const router = express.Router();
const productModel = require('../models/product');


router.get('/dashboard', (req, res) => {
    const products = productModel.getAllProducts();
    res.render('userDashboard', { products });
});


router.get('/search', (req, res) => {
    const { name, category } = req.query;
    let results = productModel.getAllProducts();  
    console.log('Search Query Params:', req.query);  

    
    if (!name && !category) {
        console.log('No search criteria provided. Returning no results.');
        results = [];  
    } else {
        if (name && name.trim() !== '') {
            console.log('Filtering by name:', name);
            results = results.filter(product => 
                product.name.toLowerCase().includes(name.toLowerCase()) 
            );
        }

        
        if (category && category.trim() !== '') {
            console.log('Filtering by category:', category);
            results = results.filter(product => 
                product.category.toLowerCase().includes(category.toLowerCase()) 
            );
        }
    }

    console.log('Filtered Results:', results);  
    res.render('userDashboard', { products: results });
});

module.exports = router;
