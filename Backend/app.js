const port=3001
const express = require('express')
const app = express()
const db=require('mongoose');
const AuthRouter = require('./routes/auth/auth');
app.use(express.json());
app.use(express.urlencoded({extended:true}));
app.listen(port,()=>{
  console.log("server is running on port "+port);
})
app.use(AuthRouter);
