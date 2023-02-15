 
 const { request, response } = require('express');
 const fs = require('fs-extra');
 const path = require('path');
 const bcrypt = require('bcrypt');
 const connect = require('../DataBase/DataBase');

 
 const socketOrderDelivery = (io) => {

    const nameSpaceOrders = io.of('/orders-delivery-socket');

    nameSpaceOrders.on('connection', socket => {
        
        console.log('USER CONECTED');

        socket.on('position', (data) => {

            // console.log(`DATA FLUTTER ${JSON.stringify(data)}`);

            nameSpaceOrders.emit(`position/${data.idOrder}`, { latitude: data.latitude, longitude: data.longitude });
            
        });

        socket.on('disconnect', (data) => {
            console.log('USER DISCONNECT');
        });

    });

} 

module.exports = {socketOrderDelivery}