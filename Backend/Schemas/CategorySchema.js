const db=require('mongoose');
const MoneyScheme = require('./MoneySchema');
const Schema = db.Schema;
const CategoryScheme=new Schema({
  Name:{
    type:String,
    required:true
  },
  Budget:{
    type:MoneyScheme,
    required:true
  }, 
  //icon(Didn't figure out the format yet):{
  //  type:String,
  //  required:true
  //}
});
module.exports=CategoryScheme;
