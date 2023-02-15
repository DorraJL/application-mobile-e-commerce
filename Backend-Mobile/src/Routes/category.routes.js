const { Router } = require('express');
const { validateToken }  = require('../Middlewares/ValidateToken');
const {  getListSousCategories,
    SupprimerCategorie,
    ajouterSousCategorie,
    ajouterCategorie,
    SupprimerSousCategorie,
    getListSousCategoriesofCategorie,
    getListCategories,
    ModifierSousCategorie,
    ModifierCategorie } = require('../Controller/category_controller');

const router = Router();

router.get('/category/get-all-categories', validateToken,  getListCategories );
router.get('/category/get-all-sub-categories', validateToken,  getListSousCategories );
router.post('/category/add-categories',validateToken, ajouterCategorie);
router.post('/category/add-sub-categories',validateToken,  ajouterSousCategorie);
router.get('/category/get-sub-categories-for-category/:id',validateToken,  getListSousCategoriesofCategorie);
router.delete('/category/delete-category/:idCategory', validateToken,SupprimerCategorie);
router.delete('/category/delete-sub-category/:idCategory', validateToken, SupprimerSousCategorie);
router.put('/category/edit-category',validateToken, ModifierCategorie);
router.put('/category/edit-sub-category',validateToken, ModifierSousCategorie);
module.exports = router;