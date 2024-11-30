const express = require('express');
const router = express.Router();
const productModel = require('../models/product');


router.get('/dashboard', (req, res) => {
    const products = productModel.getAllProducts();
    res.render('adminDashboard', { products });
});


router.get('/register', (req, res) => {
    res.render('productRegistration');
});


router.post('/add', (req, res) => {
    const { name, id, price, category, manufacturingDate, expirationDate } = req.body;

    
    if (!name || !id || !price || !category || !manufacturingDate || !expirationDate) {
        return res.status(400).send("All fields are required");
    }

    
    productModel.addProduct({ name, id, price, category, manufacturingDate, expirationDate });

    
    res.redirect('/admin/dashboard');
});

module.exports = router;
