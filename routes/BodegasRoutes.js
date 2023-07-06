//? Importaciones y declaraciones
import mysql from 'mysql2/promise';
import { Router } from 'express';
import dotenv from 'dotenv';
dotenv.config();

const BodegasRouter = Router();
let connection = undefined;
const config = JSON.parse(process.env.CONNECT);

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