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
            SELECT DISTINCT id_producto, (SELECT SUM(cantidad) FROM inventarios WHERE id_producto = t.id_producto) AS total FROM inventarios AS t WHERE id_producto IN(SELECT id_producto FROM inventarios GROUP BY id_producto HAVING COUNT(*) > 0) ORDER BY total;
        `;
        const [rows] = await connection.query(query);
        res.json(rows);
    } catch (error) {
        console.error('Error al obtener los productos:', error);
        res.status(500).json({ error: 'Ocurrió un error al obtener los productos' });

    }
});

//? Agregar un nuevo producto y añadirlo a una bodega por defecto
ProductosRouter.post('/', async (req, res) => {
    try {
        //* Recoger los datos de la petición y definir la fecha actual
        const { nombre, descripcion, estado, created_by, update_by, deleted_at, cantidad_inicial } = req.body;
        const currentDate = new Date().toISOString().slice(0, 19).replace('T', ' ');

        // //* Verificar si existe un producto con el mismo nombre
        // const searchProductQuery = 'SELECT id FROM productos WHERE nombre = ?';
        // const [commonProduct] = await connection.query(searchProductQuery, [nombre]);

        // //* Definir la bodega por defecto y el id del producto dependiendo de si existe o no
        // const productId = (commonProduct.length > 0) ? await insertExistentProduct(commonProduct[0])
        //     : await insertNewProduct();
        const bodega = 11;

        const insertProductQuery = 'INSERT INTO productos (nombre, descripcion, estado, created_by, update_by, created_at, updated_at, deleted_at) VALUES (?, ?, ?, ?, ?, ?, ?, ?)';
        await connection.query(insertProductQuery, [nombre, descripcion, estado, created_by, update_by, currentDate, currentDate, deleted_at]);

        //* Insertar registro en la tabla inventarios
        const insertInventoryQuery = 'INSERT INTO inventarios (id_bodega, id_producto, cantidad, created_by, update_by, created_at, updated_at) VALUES (?, ?, ?, ?, ?, ?, ?)';
        await connection.query(insertInventoryQuery, [bodega, productId, cantidad_inicial, created_by, update_by, currentDate, currentDate])

        res.json({ "Message": 'Producto creado y agregado al inventario en la bodega por defecto' });
    } catch (error) {
        console.error('Error al agregar los productos:', error);
        res.status(500).json({ error: 'Ocurrió un error al agregar los productos' });

    }

});

export default ProductosRouter;