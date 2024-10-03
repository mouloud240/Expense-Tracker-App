const db=require('mongoose');
const MoneyScheme = require('./MoneySchema');
const Category = require('./CategorySchema');
const Schema = db.Schema;
const ExpenseScheme=new Schema({
  Name:{
    type:String,
    required:true
  },
   Date:{
    type:Date,
    required:true
  },
  Category:{
    type:Category,
    required:true
  },
  Amount:{
    type:MoneyScheme,
    required:true,
  }
});
module.exports=ExpenseScheme;
