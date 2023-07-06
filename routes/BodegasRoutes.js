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

//? Crear bodega
BodegasRouter.post('/', async (req, res) => {
    try {
        console.log(req.body);
        const {
            nombre,
            id_responsable,
            estado,
            created_by,
            update_by,
            deleted_at
        } = req.body;

        const created_at = new Date().toISOString().slice(0, 19).replace('T', ' ');
        const updated_at = new Date().toISOString().slice(0, 19).replace('T', ' ');

        const query = `
        INSERT INTO bodegas
        (nombre, id_responsable, estado, created_by, update_by, created_at, updated_at, deleted_at)
        VALUES
        (?, ?, ?, ?, ?, ?, ?, ?)
        `;

        const values = [
            nombre,
            id_responsable,
            estado,
            created_by,
            update_by,
            created_at,
            updated_at,
            deleted_at
        ];

        await connection.query(query, values);

        res.json({ message: 'Bodega creada exitosamente' });
    } catch (error) {
        console.error('Error al crear la bodega:', error);
        res.status(500).json({ error: 'Ocurrió un error al crear la bodega' });
    }
})

export default BodegasRouter;