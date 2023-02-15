const { request, response } = require('express');
const fs = require('fs-extra');
const path = require('path');
const bcrypt = require('bcrypt');
const connect = require('../DataBase/DataBase');


const registerClient = async ( req, res = response ) => {

    const { username, phone,email, passwordd } = req.body;


    const salt = bcrypt.genSaltSync();
    const pass = bcrypt.hashSync( passwordd, salt );

    const conn = await connect();

    const hasEmail = await conn.query('SELECT email FROM users WHERE email = ?', [email]);

    if( hasEmail[0].length == 0 ){

        await conn.query(`CALL Inscription(?,?,?,?);`, [ username,phone, email, pass ]);

        conn.end();

        return res.json({
            resp: true,
            message : 'user ' + username +' ajouté avec succès!'
        });
    
    } else {
        return res.json({
            resp: false,
            message : 'Email existe déjà'
        }); 
    }

}
const AjouterUser = async ( req, res = response ) => {

    const { username, phone,email, passwordd,rol_id } = req.body;


    const salt = bcrypt.genSaltSync();
    const pass = bcrypt.hashSync( passwordd, salt );

    const conn = await connect();

    const hasEmail = await conn.query('SELECT email FROM users WHERE email = ?', [email]);

    if( hasEmail[0].length == 0 ){

        await conn.query(`CALL AjouterUtilisateur(?,?,?,?,?);`, [ username, phone, email, pass ,rol_id ]);

        conn.end();

        return res.json({
            resp: true,
            message : 'user ' + username +' succesfully added!'
        });
    
    } else {
        return res.json({
            resp: false,
            message : 'Email existe déjà'
        }); 
    }

}

const changePassword = async ( req, res = response ) => {

    try {
        const conn = await connect();
        const { currentPassword, newPassword } = req.body;

        const passworddb = await conn.query('SELECT password FROM users WHERE id = ?', [req.uidPerson]);

        if( !await bcrypt.compareSync( currentPassword, passworddb[0].passwordd )){
            return res.status(401).json({
                resp: false,
                msg : 'les deux mots de passe ne sont pas identique !'
            }); 
        }

        let salt = bcrypt.genSaltSync();
        const pass = bcrypt.hashSync( newPassword, salt );

        await conn.query('UPDATE users SET password = ? WHERE id = ?', [ pass, req.uidPerson ]);

        res.json({
            resp: true,
            msg: 'mot de passe changé'
        });
        
    } catch (e) {
        return res.status(500).json({
            resp: false,
            msg : e
        });
    }

}
const getListUsers = async (req , res = response) => {

    try {

        const conn = await connect();

        const usersdb = await conn.query(`CALL getListUsers();`);

       // await conn.end();

        return res.json({
            resp: true,
            message: 'Get All List Users',
            users:  usersdb[0][0]
        });
        
    } catch (err) {
        return res.status(500).json({
            resp: false,
            message: err,
           
        });
    }

}

const SupprimerUser = async (req=request, res = response ) => {

    try {
        const conn = await connect();
        await conn.query('DELETE FROM users WHERE id = ?', [req.params.idUser]);
        await conn.query('DELETE FROM favorite WHERE user_id = ?', [req.params.idUser]);
        const idorder = await conn.query('SELECT id FROM orders WHERE client_id = ?',  [req.params.idUser]);
        await conn.query('DELETE FROM orderdetails WHERE order_id = ?',idorder[0].id);
        await conn.query('DELETE FROM orders WHERE client_id = ?', [req.params.idUser]);
        await conn.end();
        res.json({
            resp: true,
            message : 'utilisateur supprimé avec succès'
        });
        
    } catch (e) {
        return res.status(500).json({
            resp: false,
            message : e
        });
    }

}

const getUserById = async (req = request, res = response ) => {

    try {

        const conn = await connect();

        const userdb = await conn.query(`CALL getUserById(?);`, [ req.uidPerson ]);

       // conn.end();

        return res.json({
            resp: true,
            msg: ' utilisateur ',
            user: userdb[0][0][0]
        });
        
    } catch (err) {
        return res.status(500).json({
            resp: false,
           msg: err
        });
    }

}



const getAddressesUser = async (req, res = response ) => {

    try {
        const conn = await connect();
        const addressesdb = await conn.query('SELECT id, Rue, reference, Latitude, Longitude FROM addresses WHERE user_id = ?', [req.uidPerson]);
        conn.end();
        return res.json({
            resp: true,
            msg : 'List  Adresses',
            listAddresses : addressesdb[0]
        });
        
    } catch (e) {
        return res.status(500).json({
            resp: false,
            msg : e
        });
    }

}


 const SupprimerAdresse = async (req, res = response ) => {

    try {
        const conn = await connect();
        await conn.query('DELETE FROM addresses WHERE id = ? AND user_id = ?', [ req.params.idAddress , req.uidPerson ]);
        conn.end();
        return res.json({
            resp: true,
            msg : ' Adresse supprimé avec succès'
        });
        
    } catch (e) {
        return res.status(500).json({
            resp: false,
            msg : e
        });
    }
}


 const ajouterAdresse = async ( req, res = response ) => {

    try {
        const conn = await connect();
        const { street, reference, latitude, longitude } = req.body;

        await conn.query('INSERT INTO addresses (Rue, reference, Latitude, Longitude, user_id) VALUE (?,?,?,?,?)', [ street, reference, latitude, longitude, req.uidPerson ]);
        conn.end();
        return  res.json({
            resp: true,
            msg : 'adresse ajouté avec succès'
        });

    } catch (e) {
        return res.status(500).json({
            resp: false,
            msg : e
        });
    }

}


 const getAdresse = async (req, res = response) => {

    try {
        const conn = await connect();
        const addressdb = await conn.query('SELECT * FROM addresses WHERE user_id = ? ORDER BY id DESC LIMIT 1', [ req.uidPerson ]);
        conn.end();
        return res.json({
            resp: true,
            msg : 'One Address',
            address: addressdb[0][0]
        });
        
    } catch (e) {
        return res.json({
            resp: false,
            msg : err
        }); 
    }
}


const Dashboard = async (req, res = response) => {

    try {
        const conn = await connect();
        const dash = await conn.query(`CALL Dashboard();`);
       // conn.end();
        return res.json({
            resp: true,
            msg : 'succées',
           dash: dash[0][0][0]
        });
        
    } catch (e) {
        return res.status(500).json({
            resp: false,
            msg : e
        }); 
    }
}

       


/*const ModifierAddresse = async ( req, res = response ) => {

   try {

        const { address, reference } = req.body;
        
        const conn = await connect();

        await conn.query(`CALL ModifierAdresse(?,?,?);`, [ req.uidPerson, address, reference ]);

        await conn.end();
        
        return res.json({
            resp: true,
            message: 'Street Address updated',
        });
        
    } catch (err) {
       return res.status(500).json({
           resp: false,
           message: err,
       });
   }

}*/
const ModifierProfil = async ( req, res = response ) => {

    try {
        const conn = await connect();
        const { firstname, phone,email} = req.body;

        await conn.query(`CALL ModifierProfil(?,?,?,?);`, [req.uidPerson, firstname, phone, email]);
       
        await conn.end();
      return  res.json({
            resp: true,
            message : ' Profil modifié'
        });
        
    } catch (e) {
        return res.status(500).json({
            resp: false,
            message : e
        });
    }

}



module.exports = {
    AjouterUser,
    getUserById,
    getListUsers,
    SupprimerUser,
    SupprimerAdresse,
    ajouterAdresse,
    getAdresse,
    ModifierProfil,
    changePassword ,
    registerClient,
    getAddressesUser,
    Dashboard
    
}