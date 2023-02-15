const { response, request } = require('express');
const connet = require('../DataBase/DataBase');





 const AjouterOrder = async (req, res = response ) => {

    try {
        const conn = await connet();
        const { uidAddress, total,  products } = req.body;

        const orderdb = await conn.query('INSERT INTO orders (client_id, address_id, amount) VALUES (?,?,?)', [ req.uidPerson, uidAddress, total ]);
    
        products.forEach(e => {
          conn.query('INSERT INTO orderdetails (order_id, produit_id, quantity, prix) VALUES (?,?,?,?)', [ orderdb[0].insertId, e.uidProduct, e.amount, e.amount * e.price ]);
        });
        //await conn.end();
        res.json({
            resp: true,
            msg : 'order ajouté avec succès'
        });

    } catch (e) {
        return res.status(500).json({
            resp: false,
            msg : e
        });
    }

}

 const getOrdersByStatus = async (req, res = response ) => {

    try {
        const conn = await connet();
        const ordersdb = await conn.query(`CALL getOrdersByStatus(?);`, [ req.params.statusOrder ]);
        await conn.end();
        res.json({
            resp: true,
            msg : 'Orders by ' + req.params.statusOrder,
            ordersResponse : ordersdb[0][0]
        });
        
    } catch (e) {
        return res.status(500).json({
            resp: false,
            msg : e
        });
    }

}

 const getDetailsOrderById = async ( req, res = response ) => {

    try {
        const conn = await connet();
        const detailOrderdb = await conn.query(`CALL getDétailOrdre(?);`, [ req.params.idOrderDetails ]);
        await conn.end();
        res.json({
            resp: true,
            msg : 'Order details Par ' + req.params.idOrderDetails,
            detailsOrder: detailOrderdb[0][0]
        });
        
    } catch (e) {
        return res.status(500).json({
            resp: false,
            msg : e
        });
    }

}

 const ModifierOrdreStatusToEnvoye= async ( req, res = response ) => {

    try {
        const conn = await connet();
        const { idDelivery, idOrder } = req.body;

        await conn.query('UPDATE orders SET status = ?, livreur_id = ? WHERE id = ?', [ 'ENVOYE', idDelivery, idOrder ]);
        await conn.end();
        res.json({
            resp: true,
            msg : 'Order Envoyé'
        });
        
    } catch (e) {
        return res.status(500).json({
            resp: false,
            msg : e
        });
    }

}

const ModifierOrdreStatusToAnnulé = async ( req, res = response ) => {

    try {
        const conn = await connet();
        const { idDelivery, idOrder } = req.body;

        await conn.query('UPDATE orders SET status = ?, livreur_id = ? WHERE id = ?', [ 'ANNULE', idDelivery, idOrder ]);
        await conn.end();
        res.json({
            resp: true,
            msg : 'Order Envoyé'
        });
        
    } catch (e) {
        return res.status(500).json({
            resp: false,
            msg : e
        });
    }

}


 const getOrdersByLivraison = async ( req, res = response ) => {

    try {
        const conn = await connet();
        const ordersdb = await conn.query(`CALL getOrdersByLivraison(?,?);`, [ req.uidPerson, req.params.statusOrder ]);
        await conn.end();
        res.json({
            resp: true,
            msg : 'list orders livrés',
            ordersResponse : ordersdb[0][0]
        });
        
    } catch (e) {
        return res.status(500).json({
            resp: false,
            msg : e
        });
    }

}

const ModifierOrdreStatusToEnRoute = async ( req, res = response ) => {

    try {
        const conn = await connet();
        const { latitude, longitude } = req.body;

        await conn.query('UPDATE orders SET status = ?, latitude = ?, longitude = ? WHERE id = ?', ['EN ROUTE', latitude, longitude, req.params.idOrder ]);
        await conn.end();
        res.json({
            resp: true,
            msg : 'En Route'
        });
        
    } catch (e) {
        return res.status(500).json({
            resp: false,
            msg : e
        });
    }

}

const ModifierStatusOrderToLivré = async ( req, res = response ) => {

    try {
        const conn = await connet();
        await conn.query('UPDATE orders SET status = ? WHERE id = ?', ['LIVRE', req.params.idOrder ]);
        await conn.end();
        res.json({
            resp: true,
            msg : 'ORDER Livré'
        });
        
    } catch (e) {
        return res.status(500).json({
            resp: false,
            msg : e
        });
    }

}



module.exports = {
    ModifierOrdreStatusToAnnulé,
    ModifierOrdreStatusToEnvoye,
    ModifierOrdreStatusToEnRoute,
    ModifierStatusOrderToLivré,
    getOrdersByLivraison,
    getDetailsOrderById,
    getOrdersByStatus,
    AjouterOrder 
}