const bcrypt = require('bcrypt');
const authMiddlware = require('../middlewares/authMiddlware');

const AuthRouter= require('express').Router();
const Jwt=require('jsonwebtoken');
const {v4:uuidv4}=require('uuid');
const userModel = require('../../Schemas/userShcema');
const dotnev=require('dotenv').config();
const nodemailer = require('nodemailer')
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
      const accessToken=Jwt.sign({UserId:user._id},dotnev.parsed.ACCESS_SECRET,{expiresIn:"1h"}) 
      const refreshToken=Jwt.sign({UserId:user._id},dotnev.parsed.REFRESH_SECRET,{expiresIn:"7d"})
      res.json({user:user,accesToken:accessToken,refreshToken:refreshToken});
    }else{
      res.status(401).send("Wrong Password");
    }
  }else{
    res.status(401).send("User not found");
  }
})
AuthRouter.post('/refresh',async (req,res)=>{
  const {refreshToken}=req.body;
  if (!refreshToken){
    res.status(400).send('Provide a refresh token');
    return;
  }
  Jwt.verify(refreshToken,dotnev.parsed.REFRESH_SECRET,(err,user)=>{
    if (err){
      res.status(403).send('Invalid refresh token');
      return;
    }
    const accessToken=Jwt.sign({UserId:user.UserId},dotnev.parsed.ACCESS_SECRET,{expiresIn:"1h"}) 
    const refreshToken=Jwt.sign({UserID:user.UserID},dotnev.parsed.REFRESH_SECRET,{expiresIn:"7d"})
    res.json({accesToken:accessToken,refreshToken:refreshToken});
  })
}
)
AuthRouter.post('/register',async (req,res)=>{
  const {Name,Email,Password,PayDay,totalBalance,monthlyIncome,pin}=req.body;
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
  if (!pin){
    
    return res.status(422).send("Provide a pin")
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
      pin:pin,}) 
const regUser=await user.save();
const accessToken=Jwt.sign({UserId:regUser._id},dotnev.parsed.ACCESS_SECRET,{expiresIn:"1h"}) 
const refreshToken=Jwt.sign({UserId:regUser._id},dotnev.parsed.REFRESH_SECRET,{expiresIn:"7d"})
  if (regUser){
     res.json({"user":regUser,"accesToken":accessToken,"refreshToken":refreshToken});

  }else{
    res.statusCode(500).send('Error creating your account')

  }
})
AuthRouter.put('/pin',authMiddlware,async(req,res)=>{
  const user=req.user
  console.log(user);
  if (!user){
    return res.status(405).send("Auth Error");
  }
  const pin=req.body.pin;
  console.log(req.body)
  let updatedUser;
if (!pin){
    return res.status(400).send("Provide a pin");
  }
  try{

  updatedUser= await userModel.findOneAndUpdate({_id:user.UserId},{pin:pin},{new:true});
   console.log(updatedUser);
  }catch(e){
    console.log(e);
   return res.status(500).send("Error Updating Pin")
  }
  if (updatedUser){
    return res.json(updatedUser);
  }
  return res.status(500).send("Error Updating Pin")
})
AuthRouter.post('/SendEmail',async (req,res)=>{
  const {email}=req.body;
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
    res.status(500).send('Error updating password');
 return 
  }

  res.send(hashedPassword);
  

})

AuthRouter.get('/budget',authMiddlware,async(req,res)=>{ 
 const User=req.user;
  console.log(User);
  if (!User){

    res.status(403).send('Unathorized');
  return;
}
  const id=User.UserId;
  const user=await userModel.findById(id);
  if (!user){
    res.status(404).send('User not found');
    return;
  }
  res.json(user.totalBalance)
})



module.exports=AuthRouter;
