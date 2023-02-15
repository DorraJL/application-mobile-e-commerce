const { response, request } = require('express');
const connet = require('../DataBase/DataBase');


const getListLivreurs = async ( req, res = response ) => {

    try {
        const con = await connet();
        let deliverydb = await con.query(`CALL getListLivreurs();`);
        await con.end();
        res.json({
            resp: true,
            msg : 'Livreur',
            delivery: deliverydb[0][0] 
        });
        
    } catch (e) {
        return res.status(500).json({
            resp: false,
            msg : e
        });
    }

}


module.exports = {
    getListLivreurs
   
};