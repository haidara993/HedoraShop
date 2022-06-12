const {Checkout} = require('../models/checkout');
const express = require('express');
const router = express.Router();

router.get('/:id', async(req,res)=>{
    const checkout = await Checkout.findById(req.params.id);

    if(!checkout) {
        res.status(500).json({message: 'The checkout with the given ID was not found.'})
    } 
    res.status(200).send(checkout);
});

router.post('/',async (req,res)=>{
    let checkout = new Checkout({
        street:req.body.street,
        city:req.body.city,
        state:req.body.state,
        country:req.body.country,
        phone:req.body.phone,
        totalPrice:req.body.totalPrice,
        date:req.body.date,
        user:req.body.user
    })
    checkout = await checkout.save();

    if(!checkout)
    return res.status(400).send('the checkout cannot be created!')

    res.send(checkout);
});

module.exports = router;