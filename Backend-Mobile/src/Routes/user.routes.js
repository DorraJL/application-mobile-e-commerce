const { Router } = require('express');
const { AjouterUser,
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
    Dashboard,} = require('../Controller/UserController');
const { validateToken }  = require('../Middlewares/ValidateToken');

const router = Router();

    router.post('/user/add-new-user', AjouterUser);
    router.post('/user/register-client',  registerClient );
    router.get('/user/get-user-by-id', validateToken, getUserById);
   // router.put('/user/update-street-address', validateToken, ModifierAddress);
    router.get('/user/get-all-users', validateToken,  getListUsers);
    router.get('/user/get-addresses', validateToken, getAddressesUser );
    router.delete('/user/delete-street-address/:idAddress', validateToken,  SupprimerAdresse );
    router.post('/user/add-new-address', validateToken, ajouterAdresse );
    router.get('/user/get-address', validateToken, getAdresse);
    router.get('/user/get-dash', validateToken, Dashboard );
    router.put('/user/edit-profile',validateToken,  ModifierProfil);
    router.put('/user/change-password', validateToken, changePassword);
    router.delete('/user/delete-user/:idUser', validateToken, SupprimerUser);
module.exports = router;