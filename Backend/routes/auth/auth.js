const bcrypt = require('bcrypt');
const router= require('express').Router();

router.post('/login',async (req,res)=>{
  const {email,password}=req.body;
  const user = await userModel.findOne({email:email});
  if(user){
    if(await bcrypt.compare(password,user.password)){
      res.send("Logged in");
    }else{
      res.send("Wrong password");
    }
  }else{
    res.send("User not found");
  }
})

router.post('/register',async (req,res)=>{
  const {name,email,password}=req.body;
  const hashedPassword = await bcrypt.hash(password,10);
  const user = new userModel({
    name:name,
    email:email,
    password:hashedPassword
  });
  user.save();
  res.send("User registered");
})

module.exports=router;
