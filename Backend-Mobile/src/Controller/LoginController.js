const { response, request } = require('express');
const connet = require('../DataBase/DataBase');
const bcrypt = require('bcrypt');
const { generarJsonWebToken } = require('../Helpers/JWToken');



const loginController = async ( req = request, res = response ) => {
    
    const { email, passwordd } = req.body;

    try {
 
         const conn = await connet();
 
         const existsEmail = await conn.query('SELECT id, email, password FROM users WHERE email = ? ', [ email ]);
 
         if( existsEmail[0].length === 0 ){
            // conn.end();
             return res.status(400).json({
                 resp: false,
                msg: 'Votre email ou mot de passe est incorrect ! Veuillez réessayer.'
             });
         }
 
 
         const validatedPassword = await bcrypt.compareSync( passwordd, existsEmail[0][0].passwordd );
 
         if( !validatedPassword ){
 
           //  conn.end();
             return res.status(400).json({
                 resp: false,
                msg: 'Votre email ou mot de passe est incorrect ! Veuillez réessayer.'
             }); 
             
         }
 
         const token = await generarJsonWebToken( existsEmail[0][0].id );
         const userdb = await conn.query(`CALL getUserById(?);`, [existsEmail[0][0].id]);

         const user = userdb[0][0][0];
 
     //  conn.end();
         return res.json({
             resp: true,
             msg : 'Welcome to Tech4iot Store',
             user: user,
             token: token
         });
 
         
 
    } catch (err) {
         return res.status(500).json({
             resp: false,
             msg : err
         });
    }
 }
 
const  renewTokenLogin = async ( req = request, res = response ) => {

    try {
        const con = await connet();
        const token = await generarJsonWebToken( req.uidPerson );

        const userdb = await con.query(`CALL RENEWTOKENLOGIN(?);`, [ req.uidPerson ]);

        const user = userdb[0][0][0];
        
        res.json({
            resp: true,
            msg : 'Welcome to Tech4Iot Store',
            user: {
                uid: user.uid,
                firstName: user.firstName,
                phone: user.phone,
                email: user.email,
                rol_id: user.rol_id,
                token: user.token
            },
            token: token
        });
        
    } catch (e) {
       return res.status(500).json({
            resp: false,
            msg : e
        });
    }

}

module.exports = {
    loginController,
    renewTokenLogin
};