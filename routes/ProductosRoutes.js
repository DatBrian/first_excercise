//? Importaciones y declaraciones
import mysql from 'mysql2/promise';
import { Router } from 'express';
import dotenv from 'dotenv';
dotenv.config();

const ProductosRouter = Router();
let connection = undefined;
const config = JSON.parse(process.env.CONNECT);

//? Conexión a la base de datos
ProductosRouter.use((req, res, next) => {
    try {
        connection = mysql.createPool(config);
        next();
    } catch (error) {
        console.error('Error de conexión', error);
        res.status(500).json({ error: 'Ocurrió un error al configurar la conexión a la base de datos' });
    }
})

//? Obtener Productos
ProductosRouter.get('/', async (req, res) => {
    try {
        const query = `
            SELECT p.*, SUM(i.cantidad) AS Total
            FROM productos p
            JOIN inventarios i ON p.id = i.id_producto
            GROUP BY p.id
            ORDER BY Total DESC
        `;
        const [rows] = await connection.query(query);
        res.json(rows);
    } catch (error) {
        console.error('Error al obtener los productos:', error);
        res.status(500).json({ error: 'Ocurrió un error al obtener los productos' });

    }
});

export default ProductosRouter;