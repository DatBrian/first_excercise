
//? Dependencies
import dotenv from 'dotenv';
import express from 'express';

dotenv.config();
const port = process.env.PORT;
const host = process.env.HOST;
const app = express();

//? Routes
import BodegasRouter from './routes/BodegasRoutes.js';

app.use("/bodegas", BodegasRouter);

const config = JSON.parse(process.env.CONFIG);

//? Levantar el servidor
app.listen(config, () => {
    console.log(`Servidor listo en http://${config.hostname}:${config.port}`);
});