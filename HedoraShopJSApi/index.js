const express = require('express');
const app = express();
const bodyParser = require('body-parser');
const morgan = require('morgan');
const mongoose = require('mongoose');
const cors = require('cors');
require('dotenv/config');
const authJwt = require('./helpers/jwt');
const errorHandler = require('./helpers/error-handler');


app.use(cors());
app.options("*",cors());

app.use(express.json());
app.use(bodyParser.json());
app.use(morgan('tiny'));
app.use(authJwt());
app.use("/public/uploads", express.static(__dirname + "/public/uploads"));
app.use(errorHandler);


const categoriesRoutes = require('./routes/category');
const productsRoutes = require('./routes/product');
const usersRoutes = require('./routes/users');
const checkoutsRoutes = require('./routes/checkout');

const api = process.env.API_URL;

app.use(`${api}/categories`, categoriesRoutes);
app.use(`${api}/products`, productsRoutes);
app.use(`${api}/users`, usersRoutes);
app.use(`${api}/checkout`, checkoutsRoutes);


mongoose
  .connect(process.env.CONNECTION_STRING, {
    useNewUrlParser: true,
    useUnifiedTopology: true,
    dbName: process.env.DB_NAME,
  }).then(()=>{
console.log("Database is ready");
}).catch((err) => {
console.log(err);
});

const PORT = process.env.PORT || 8080
app.listen(PORT,()=>{
    console.log('server is running ........');
});