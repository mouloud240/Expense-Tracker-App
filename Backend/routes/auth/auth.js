const bcrypt = require('bcrypt');
const AuthRouter= require('express').Router();

const {v4:uuidv4}=require('uuid');
const userModel = require('../../Schemas/userShcema');
const MoneyScheme = require('../../Schemas/MoneySchema');
AuthRouter.post('/login',async (req,res)=>{
  const {email,password}=req.body;
  const user = await userModel.findOne({Email:email});
  if (!email){
    res.send('Provide an email');
    return;
  }
if (!password){
    res.send('Provide a password');
    return;
  }
  if(user){
    if(await bcrypt.compare(password,user.Password)){
      res.send("Logged in");
    }else{
      res.send("Wrong password");
    }
  }else{
    res.send("User not found");
  }
})

AuthRouter.post('/register',async (req,res)=>{
  const id=uuidv4();
  const {name,email,password}=req.body;
  if (!name){
    res.send('Provide a name')
    return;
  }
  if(!password){
    res.send('Provide a password')
    return;
  }
  if (!email){
    res.send('Provide an email')
    return;
  }
  const hashedPassword = await bcrypt.hash(password,10);
  console.log(id)
  console.log(email);
  console.log(name);
  const user =new userModel({
    Name: name,
      Email: email,
      Password: hashedPassword,
      CustomCategories: [], // Optional: Initialize as empty
      Expenses: [], // Optional: Initialize as empty
      totalBalance: 0, // Initialize to 0
      monthlyIncome: {Amount: 0, Currency: 'usd' }, // Initialize with money schema
      monthlyExpense:[], 
      PayDay: "2024-10-02 20:50", // Set accordingly or initialize
      Jwt:id   }) 
const regUser=await user.save()
  if (regUser){
     res.send(regUser);

  }else{
    res.statusCode(500).send('Error creating your account')

  }
})

module.exports=AuthRouter;
