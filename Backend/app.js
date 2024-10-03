const port=3001
const express = require('express')
const app = express()
const db=require('mongoose');
const AuthRouter = require('./routes/auth/auth');
const expsenseRouter = require('./routes/expenses/expenses');
const categoriesRouter = require('./routes/categories/categoriesRoutes');
app.use(express.json());
app.use(express.urlencoded({extended:true}));
const dbUri="mongodb://localhost:27017/expenses"
db.connect(dbUri).then(()=>{
  console.log("Connected to db")
})
app.listen(port,()=>{
  console.log("server is running on port "+port);
})

app.use(AuthRouter);
app.use(expsenseRouter)
app.use(categoriesRouter)
