const express = require("express");
const route = express();
const stripetest = require('stripe')("sk_test_51IZr3HApYMiHRCEP3ARAasN3fEj78VcsA4ordo3ktXVa0K8jrJF6443FXsNSK7jrTFxqMJMJzZdaE7JWNY9eahL900t6hvZCVR"); // replace STRIPE_SECRET_KEY with value



route.get('/', async (req, res) => {
    const paymentIntent = await stripetest.paymentIntents.create({
        amount: parseInt(req.query.amount),
        currency: req.query.currency,
    }, function (error, paymentIntent) {
        if (error != null) {
            console.log(error);
            res.json({ "error": error });
        } else {
            res.json({
                paymentIntent: paymentIntent.client_secret,
                paymentIntentData: paymentIntent,
                amount: req.body.amount,
                currency: req.body.currency
            });
        }
    });
});


module.exports = route;