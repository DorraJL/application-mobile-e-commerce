const { Router } = require('express');
const { validateToken }  = require('../Middlewares/ValidateToken');
const { ModifierOrdreStatusToAnnulĂ©,
    ModifierOrdreStatusToEnvoye,
    ModifierOrdreStatusToEnRoute,
    ModifierStatusOrderToLivrĂ©,
    getOrdersByLivraison,
    getDetailsOrderById,
    getOrdersByStatus,
    AjouterOrder  } = require('../Controller/OrdersController');
const {getListOrdersClient} = require('../Controller/ClientController');
const {getListLivreurs} = require('../Controller/LivraisonController');
const router = Router();


router.post('/order/add-new-orders', validateToken, AjouterOrder );
router.get('/order/get-orders-by-status/:statusOrder', validateToken, getOrdersByStatus  );
router.get('/order/get-details-order-by-id/:idOrderDetails', validateToken, getDetailsOrderById );
router.put('/order/update-status-order-dispatched', validateToken, ModifierOrdreStatusToEnvoye );
router.get('/order/get-all-orders-by-delivery/:statusOrder', validateToken, getOrdersByLivraison);
router.put('/order/update-status-order-on-way/:idOrder', validateToken, ModifierOrdreStatusToEnRoute);
router.put('/order/update-status-order-canceled/:idOrder', validateToken, ModifierOrdreStatusToAnnulĂ©);
router.put('/order/update-status-order-delivered/:idOrder', validateToken, ModifierStatusOrderToLivrĂ© );
router.get('/client/get-list-orders-for-client', validateToken,getListOrdersClient);
router.get('/order/get-all-delivery', validateToken,getListLivreurs);



module.exports = router;