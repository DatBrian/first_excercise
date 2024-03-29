//? Dependencies
import dotenv from 'dotenv';
import express from 'express';

dotenv.config();
const app = express();
app.use(express.json())

//? Routes
import BodegasRouter from './routes/BodegasRoutes.js';
app.use("/bodegas", BodegasRouter);

import ProductosRouter from './routes/ProductosRoutes.js';
app.use("/productos", ProductosRouter);

//? Levantar el servidor
const config = JSON.parse(process.env.CONFIG);
app.listen(config, () => {
    console.log(`Servidor listo en http://${config.hostname}:${config.port}`);
});