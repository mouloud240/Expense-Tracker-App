//Importing the required modules
const express = require('express')
const app = express()
const db=require('mongoose');
const dotnev=require('dotenv').config();
const cors=require('cors');
const AuthRouter = require('./routes/auth/auth');
const expsenseRouter = require('./routes/expenses/expenses');
const categoriesRouter = require('./routes/categories/categoriesRoutes');
//Definig constants Needed
const corsOptions={
  origin:'*',
  optionsSuccessStatus: 200 // Ensure compatibility by setting OPTIONS success status to 200 OK.
};
const port=3001
const dbUri=dotnev.parsed.DB_URI;
//Middlewares
app.use(cors(corsOptions))
app.use(express.json());
app.use(express.urlencoded({extended:true}));
//Routes
app.use(AuthRouter);
app.use(expsenseRouter)
app.use(categoriesRouter)
//Database Connection
db.connect(dbUri).then(()=>{
  app.listen(port,()=>{
  console.log("server is running on port "+port);
})
})



