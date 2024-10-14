const bcrypt = require('bcrypt');
const AuthRouter= require('express').Router();

const {v4:uuidv4}=require('uuid');
const userModel = require('../../Schemas/userShcema');
const MoneyScheme = require('../../Schemas/MoneySchema');
const dotnev=require('dotenv').config();

const nodemailer = require('nodemailer');
AuthRouter.post('/login',async (req,res)=>{
  const {email,password}=req.body;
  const user = await userModel.findOne({Email:email});
  if (!email){
    res.status(400).send('Provide an email');
    return;
  }
if (!password){
    res.status(400).send('Provide a password');
    return;
  }
  if(user){
    if(await bcrypt.compare(password,user.Password)){
      res.json({user:user});
    }else{
      res.status(401).send("Wrong password");
    }
  }else{
    res.status(401).send("User not found");
  }
})

AuthRouter.post('/register',async (req,res)=>{
  const id=uuidv4();
  const {Name,Email,Password,PayDay,totalBalance,monthlyIncome}=req.body;
  if (!Name){
    res.status(422).send('Provide a name')
    return;
  }
  if(!Password){
    res.status(422).send('Provide a password')
    return;
  }
  if (!Email){
    res.status(422).send('Provide an email')
    return;
  }
  if (!PayDay){
    res.status(422).send('Provide a PayDay')
    return;
  }
  if (!totalBalance){
    res.status(422).send('Provide a totalBalance')
    return;
  }
  if (!monthlyIncome){
    res.status(422).send('Provide a monthlyIncome')
    return;
  
  }
  const userExists=await userModel.findOne({Email:Email});
  if (userExists){
    res.status(409).send('User already exists')
    return;
  }
  const hashedPassword = await bcrypt.hash(Password,5);

  const user =new userModel({
    Name: Name,
      Email: Email,
      Password: hashedPassword,
      CustomCategories: [], // Optional: Initialize as empty
      Expenses: [], // Optional: Initialize as empty
      totalBalance: totalBalance, // Initialize to 0
      monthlyIncome:monthlyIncome, // Initialize with money schema
      monthlyExpense:[], 
      PayDay: PayDay, // Set accordingly or initialize
      Jwt:id   }) 
const regUser=await user.save()
  if (regUser){
     res.send(regUser);

  }else{
    res.statusCode(500).send('Error creating your account')

  }
})
AuthRouter.post('/SendEmail/:email',async (req,res)=>{
  const {email}=req.params;
  const Otp=uuidv4().substring(0,6);
  let mailOptions = {
    from: 'trackiexpense@gmail.com',   // Sender address
    to:email , // List of receivers
    subject: 'Reset Password',  // Subject line
    text: `We received a request to reset your password. Enter the Pin below to Your app:\n${Otp}\nThis link will expire in [time period, e.g., 24 hours]. If you didn’t request this, please ignore the email.\nThanks,` , // Plain text body
};

  const user = await userModel.findOne({Email:email});
  if (user){

    let transoprter=nodemailer.createTransport(
      {
        service:'gmail',
        auth:{
          user:dotnev.parsed.MAIL,
          pass:dotnev.parsed.PASS,
     }}

    )

    //send email
  
    transoprter.sendMail(mailOptions,(err,info)=>{
      if(err){
        console.log(err);
        res.status(500).send('Error sending email');
        return;
      }
    res.json({Otp:Otp})
    }
      );
    

    

    
  }else{
    res.status(404).send('User not found');
  }
}
)
AuthRouter.put('/forgotPassword',async (req,res)=>{
  const {newPassword,email}=req.body;
  if (!newPassword){
    res.status(400).send('Provide a new password');
    return;
  }
  if (!email){
    res.status(400).send('Provide an email');
    return;
  }
  const hashedPassword=await bcrypt.hash(newPassword,5);
try{

  await userModel.findOneAndUpdate({Email:email},{Password:hashedPassword});
  }catch(err)
{
     console.log(err)
    res.status(500).send('Error updating password');
 return 
  }
  res.send(hashedPassword);
  

})
module.exports=AuthRouter;
