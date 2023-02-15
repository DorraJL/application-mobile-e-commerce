
const { createPool } = require('mysql2/promise');


module.exports = connect = async () => {

    const connection = await createPool({
        host: 'localhost',
        user: 'dorra',
        password: 'dorra',
        database: 'productshop',
        port: "3306"
    });

    return connection;
  

}