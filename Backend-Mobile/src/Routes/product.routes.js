const { Router } = require('express');
const {  getProduitsForHomeCarousel,
    SupprimerProduit,
    ModifierProduit,
    getProduitsbyprix,
    ajouterProduit ,
    getProduitsBySousCategorie,
    getListFavoriesForUser,
    likeOrUnlikeProduit,
    RechercherProduit,
    getListProduits} = require('../Controller/ProductController');
const { validateToken }  = require('../Middlewares/ValidateToken');
const { uploadsProduct } = require('../Helpers/Multer');

const router = Router();

    router.get('/product/get-home-products-carousel', validateToken,  getProduitsForHomeCarousel );
    router.get('/product/get-products', validateToken,getListProduits);
    router.post('/product/like-or-unlike-product', validateToken,  likeOrUnlikeProduit);
    router.get('/product/get-all-favorite', validateToken, getListFavoriesForUser);
    router.get('/product/get-products-for-category/:idCategory', validateToken, getProduitsBySousCategorie);
    router.post('/product/add-new-product', [validateToken, uploadsProduct.single('productImage')],  ajouterProduit);
    router.get('/product/search-product-for-name/:nameProduct', validateToken,RechercherProduit);
    router.put('/product/update-product', [validateToken, uploadsProduct.single('productImage')], ModifierProduit);
    router.delete('/product/delete-product/:idProduct', validateToken,  SupprimerProduit);
    router.get('/product/get-products-price/:pricemin/:pricemax', validateToken,  getProduitsbyprix);
    

module.exports = router;