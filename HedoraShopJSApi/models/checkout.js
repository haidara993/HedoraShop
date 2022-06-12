const mongoose = require('mongoose');

const checkoutSchema = mongoose.Schema({
    street:{
        type:String,
    },
    city:{
        type:String,
    },
    state:{
        type:String,
    },
    country:{
        type:String,
    },
    phone:{
        type:String,
    },
    totalPrice:{
        type:String,
    },
    date:{
        type:String,
    },
    user:{
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User',
        required:true
    },
});

checkoutSchema.virtual('id').get(function () {
    return this._id.toHexString();
});

checkoutSchema.set('toJSON', {
    virtuals: true,
});

exports.Checkout = mongoose.model('Checkout',checkoutSchema);