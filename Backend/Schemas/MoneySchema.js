const db=require('mongoose');
const Schema = db.Schema;
const MoneyScheme=new Schema({
  Amount:{
    type:Number,
    required:true
  },
  Currency:{
    type:String,
    required:true
  },
  
});
module.exports=MoneyScheme;
