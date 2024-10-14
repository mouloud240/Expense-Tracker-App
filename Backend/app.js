const port=3001
const express = require('express')
const app = express()
const db=require('mongoose');
const cors=require('cors');
const mailer=require('nodemailer');
const AuthRouter = require('./routes/auth/auth');
const expsenseRouter = require('./routes/expenses/expenses');
const categoriesRouter = require('./routes/categories/categoriesRoutes');
const corsOptions={
  origin:'*',
  optionsSuccessStatus: 200 // Ensure compatibility by setting OPTIONS success status to 200 OK.
};

app.use(cors(corsOptions))
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
