const { Router } = require('express');
const { loginController, renewTokenLogin } = require('../Controller/LoginController');
const { validateToken } = require('../Middlewares/ValidateToken');

const router = Router();

    router.post('/auth/login', loginController);
    router.get('/auth/renew-login', validateToken ,renewTokenLogin );
   
module.exports = router;