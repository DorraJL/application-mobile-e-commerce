const { response, request } = require('express');
const connet = require('../DataBase/DataBase');

const getListSousCategoriesofCategorie = async (req = request, res = response) => {

    try {

        const conn = await connet();

        const categories = await conn.query(`CALL getListSousCategories(?);`, [ req.params.id]); 

        await conn.end();

        res.json({
            resp: true,
            message : 'List categories',
            listcategories: categories[0][0] 
        });
        
    } catch (err) {
        return res.status(500).json({
            resp: false,
            message: err
        });
    }

}
const SupprimerCategorie = async (req, res = response ) => {

    try {
        const conn = await connet();
        await conn.query('DELETE FROM SubCategory WHERE categorie_id = ?', [ req.params.idCategory ]);
        await conn.query('DELETE FROM category WHERE idCategorie = ?', [ req.params.idCategory ]);
        await conn.query('DELETE FROM products WHERE categorie_id = ?', [ req.params.idCategory ]);
        await conn.end();
        res.json({
            resp: true,
            msg : 'categorie supprimer avec succès'
        });
        
    } catch (e) {
        return res.status(500).json({
            resp: false,
            msg : e
        });
    }

}
const SupprimerSousCategorie = async (req, res = response ) => {

    try {
        const conn = await connet();
        await conn.query('DELETE FROM products WHERE souscategorie_id = ?', [ req.params.idCategory ]);
        await conn.query('DELETE FROM subcategory WHERE idSousCategorie = ?', [ req.params.idCategory ]);
        await conn.end();
        res.json({
            resp: true,
            msg : 'souscategorie supprimer avec succès'
        });
        
    } catch (e) {
        return res.status(500).json({
            resp: false,
            msg : e
        });
    }

}
const ajouterCategorie = async (req = request, res = response) => {

    try {

        const { category} = req.body;

        const conn = await connet();

        await conn.query('INSERT INTO category (nomCategorie) VALUE (?)', 
            [ category ]);

        await conn.end();   

        return res.json({
            resp: true,
            message: 'Categorie ajouté avec succès'
        })
        
    } catch (err) {
        return res.status(500).json({
            resp: false,
            message: err
        });
    }
}

const ajouterSousCategorie = async (req = request, res = response) => {

    try {

        const { category, uidCategory } = req.body;

        const conn = await connet();

        await conn.query('INSERT INTO subcategory (nomSousCategorie, categorie_id) VALUE (?,?)', 
            [ category, uidCategory ]);

        await conn.end();   

        return res.json({
            resp: true,
            message: 'SousCategorie ajouté avec succès'
        })
        
    } catch (err) {
        return res.status(500).json({
            resp: false,
            message: err
        });
    }
}
const getListSousCategories = async ( req = request, res = response ) => {

    try {

        const conn = await connet();

        const categories = await conn.query('SELECT idSousCategorie , nomCategorie, categorie_id FROM SubCategory');

        await conn.end();

        return res.json({
            resp: true,
            message: 'Get all categories',
            categories: categories[0]
        });
        
    } catch (err) {
        return res.status(500).json({
            resp: false,
            message: err
        });
    }

}

const getListCategories = async ( req = request, res = response ) => {

    try {

        const conn = await connet();

        const categories = await conn.query('SELECT * FROM Category');

        await conn.end();

        return res.json({
            resp: true,
            message: 'Liste categories',
            categories: categories[0]
        });
        
    } catch (err) {
        return res.status(500).json({
            resp: false,
            message: err
        });
    }

}
const ModifierSousCategorie = async ( req, res = response ) => {

    try {
        const conn = await connect();
        const { id,category } = req.body;

        await conn.query(`CALL ModifierSousCategorie(?,?);`, [id,category ]);
       
        await conn.end();
      return  res.json({
            resp: true,
            message : 'souscategorie modifié'
        });
        
    } catch (e) {
        return res.status(500).json({
            resp: false,
            message : e
        });
    }

}
const ModifierCategorie = async ( req, res = response ) => {

    try {
        const conn = await connect();
        const { id,category} = req.body;

        await conn.query(`CALL ModifierCategorie(?,?);`, [id,category]);
       
        await conn.end();
      return  res.json({
            resp: true,
            message : 'categorie modifié'
        });
        
    } catch (e) {
        return res.status(500).json({
            resp: false,
            message : e
        });
    }

}

module.exports = {
    getListSousCategoriesofCategorie,
    SupprimerCategorie,
    ajouterSousCategorie,
    ajouterCategorie,
    SupprimerSousCategorie,
    getListSousCategories,
    getListCategories,
    ModifierSousCategorie,
    ModifierCategorie 
}