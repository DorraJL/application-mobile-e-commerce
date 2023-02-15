const { response, request } = require('express');
const connet = require('../DataBase/DataBase');

const getListOrdersClient = async (req, res = response) => {

    try {
        const con = await connet();
        const listdb = await con.query(`CALL getOrdersClient(?);`, [req.uidPerson]);
        await con.end();
        res.json({
            resp: true,
            msg : 'List orders for client',
            ordersClient: listdb[0][0]
        });
        
    } catch (e) {
        return res.status(500).json({
            resp: false,
            msg : e
        });
    }


}


module.exports = {
    getListOrdersClient
   
};