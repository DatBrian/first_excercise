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


//? Levantar el servidor
app.listen(process.env.CONFIG, () => {
    console.log(`Servidor listo en ${host}:${port}`);
});
