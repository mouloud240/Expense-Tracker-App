const Jwt=require('jsonwebtoken');
const dotnev=require('dotenv').config();
function authinticate(req,res,next){
   const token = req.headers['authorization'];
  
  if (!token){
    return res.status(401).send('Provide a token');
  }
  Jwt.verify(token,dotnev.parsed.ACCESS_SECRET,(err,user)=>{
    if (err){
      return res.status(403).send('Token is not valid');
    }
    req.user=user
    next();
  })

}
module.exports=authinticate;
