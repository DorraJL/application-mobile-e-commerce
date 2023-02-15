
const express = require('express');
const path = require('path');

require('dotenv').config();
const { createServer } = require('http');
const Server = require('socket.io');
const { socketOrderDelivery } = require('./Sockets/SocketOrderDelivery');
const app = express();

// Middleware
app.use( express.json() );
app.use( express.urlencoded({ extended: false }) );


// CONFIG SOCKET 
const httpServer = createServer(app);
const io = new Server(httpServer);
socketOrderDelivery(io);

// Routes
app.use('/api', require("./Routes/user.routes"));
app.use('/api', require("./Routes/auth.routes"));
app.use('/api', require("./Routes/product.routes"));
app.use('/api', require("./Routes/category.routes"));
app.use('/api', require("./Routes/Order.routes"));

// Photos
app.use( express.static( path.join( __dirname, 'Uploads/Home' )));
app.use( express.static( path.join( __dirname, 'Uploads/Products' )));



module.exports = app;
