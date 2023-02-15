const { response, request } = require('express');
const connet = require('../DataBase/DataBase');



const getProduitsForHomeCarousel = async ( req = request, res = response ) => {

    try {

        const conn = await connet();

        const rows = await conn.query('SELECT * FROM Home_carousel');

        await conn.end();

        return res.json({
            resp: true,
            message: ' List produits home',
            slideProducts: rows[0]
        });
        
    } catch (err) {
        return res.status(500).json({
            resp: false,
            message: err
        });
    }

}

const getListProduits = async (req = request, res = response) => {

    try {

        const conn = await connet();

        const products = await conn.query(`CALL getListProduits(?);`,[ req.uidPerson ]);

        await conn.end();

        return res.json({
            resp: true,
            message: ' List Produits ',
            listProducts: products[0][0]
        });
        
    } catch (err) {
        return res.status(500).json({
            resp: false,
            message: err
        });
    }
}


 const RechercherProduit = async (req = request, res = response) => {

    try {

        const conn = await connet();
        const  listProducts = await conn.query(`CALL RechercherProduit(?,?);`, [ req.uidPerson, req.params.nameProduct ]);
        await conn.end();
      res.json({
            resp: true,
            message : 'Search products',
            listProducts: listProducts[0][0]
        });
        
    } catch (err) {
        return res.status(500).json({
            resp: false,
            message: err
        });
    }

}
const likeOrUnlikeProduit = async (req = request, res = response) => {

    try {

        const { uidProduct } = req.body;

        const conn = await connet();

        const isLike = await conn.query('SELECT COUNT(idFavorie) isfavorite FROM favorite WHERE user_id = ? AND produit_id = ?', [ req.uidPerson, uidProduct ]);

        if( isLike[0][0].isfavorite > 0 ){

            await conn.query('DELETE FROM favorite WHERE user_id = ? AND produit_id = ?', [ req.uidPerson, uidProduct ]);

            await conn.end();

            return res.json({
                resp: true,
                message: 'Unlike'
            });
        }

        await conn.query('INSERT INTO favorite (user_id, produit_id) VALUE (?,?)', [ req.uidPerson, uidProduct ]);

        await conn.end();

        return res.json({
            resp: true,
            message: 'Like'
        });
        
    } catch (err) {
        return res.status(500).json({
            resp: false,
            message: err
        });
    }

}


const getListFavoriesForUser = async (req = request, res = response) => {

    try {

        const conn = await connet();

        const listProducts = await conn.query(`CALL getListFavories(?);`, [ req.uidPerson ]);

        await conn.end();

        res.json({
            resp: true,
            message : 'List produits favories',
            listProducts: listProducts[0][0]
        });
        
    } catch (err) {
        return res.status(500).json({
            resp: false,
            message: err
        });
    }
}

const getProduitsBySousCategorie = async (req = request, res = response) => {

    try {

        const conn = await connet();

        const products = await conn.query(`CALL getProduitsBySousCategorie(?,?);`, [ req.params.idCategory, req.uidPerson ]); 

        await conn.end();

        res.json({
            resp: true,
            message : 'List Products',
            listProducts: products[0][0] 
        });
        
    } catch (err) {
        return res.status(500).json({
            resp: false,
            message: err
        });
    }

}


const ajouterProduit = async (req = request, res = response) => {

    try {

        const { name, description, stock, price, uidCategory,uidsousCategory,color } = req.body;

        const conn = await connet();

        await conn.query('INSERT INTO Products (nomProduit, description, stock, prix, image, souscategorie_id, categorie_id,couleur) VALUE (?,?,?,?,?,?,?,?)', 
            [ name, description, stock, price, req.file.filename,uidsousCategory, uidCategory,color ]);

        await conn.end();   

        return res.json({
            resp: true,
            message: 'Produit Ajouté avec succès'
        })
        
    } catch (err) {
        return res.status(500).json({
            resp: false,
            message: err
        });
    }
}





const getProduitsbyprix= async ( req, res = response ) => {

    try {

        const conn = await connet();
       
        const products = await conn.query(`CALL getListProduitsByPrix(?,?,?);`, [ req.uidPerson, req.params.pricemin, req.params.pricemax]);

        await conn.end();

        res.json({
            
            resp: true,
            message : 'List Products',
            listProducts: products[0][0] 
        });
        
    } catch (err) {
        return res.status(500).json({
            resp: false,
            message: err,  });
    }
    }
   




const ModifierProduit = async (req, res = response) => {

    try {
        const conn = await connet();
        const { nameProduct, description, stock, price,status, uidProduct} = req.body;

        await conn.query('UPDATE products SET nomProduit =?, description=?,  stock=?, prix=?,status = ?, image=? WHERE idProduit = ?', [nameProduct, description, stock, price, status,req.file.filename, uidProduct ]);
        await conn.end();
        res.json({
            resp: true,
            msg : 'Product updated'
        });
        
    } catch (e) {
        return res.status(500).json({
            resp: false,
            msg : e
        });
    }

}

const SupprimerProduit = async (req, res = response ) => {

    try {
        const conn = await connet();
        await conn.query('DELETE FROM orderdetails WHERE produit_id = ?', [ req.params.idProduct ]);
        await conn.query('DELETE FROM favorite WHERE produit_id = ?', [ req.params.idProduct ]);
        await conn.query('DELETE FROM products WHERE idProduit = ?', [ req.params.idProduct ]);
        await conn.end();
        res.json({
            resp: true,
            msg : 'Produit supprimé avec succès'
        });
        
    } catch (e) {
        return res.status(500).json({
            resp: false,
            msg : e
        });
    }

}



module.exports = {
    getProduitsForHomeCarousel ,
    SupprimerProduit,
    ModifierProduit,
    getProduitsbyprix,
    ajouterProduit ,
    getProduitsBySousCategorie,
    getProduitsBySousCategorie,
    getListFavoriesForUser,
    likeOrUnlikeProduit,
    RechercherProduit,
    getListProduits
}