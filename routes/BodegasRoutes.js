//? Importaciones y declaraciones
import mysql from 'mysql2';
import { Router } from 'express';

const BodegasRouter = Router();
let connection = undefined;
const config = {
    host: process.env.HOST,
    user: process.env.USER,
    password: process.env.PASSWORD,
    database: process.env.DB_NAME
};

//? Conexión a la base de datos
BodegasRouter.use((req, res, next) => {
    try {
        connection = mysql.createPool(config);
        next();
    } catch (error) {
        console.error('Error de conexión:', error);
        res.status(500).json({ error: 'Ocurrió un error al configurar la conexión a la base de datos' });
    }
})

//? Obtener todas las bodeegas
BodegasRouter.get('/', async (req, res) => {
    try {
        const query = 'SELECT * FROM bodegas ORDER BY nombre ASC';
        const [rows] = await connection.query(query);
        res.json(rows);
    } catch (error) {
        console.error('Error al obtener las bodegas:', error);
        res.status(500).json({ error: 'Ocurrió un error al obtener las bodegas' });
    }
})



export default BodegasRouter;