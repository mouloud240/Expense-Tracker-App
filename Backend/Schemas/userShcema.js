const db=require('mongoose');
const CategoryScheme = require('./CategorySchema');
const ExpenseScheme = require('./ExpenseSchema');
const MoneyScheme = require('./MoneySchema');
const Schema = db.Schema;
const UserSchema=new Schema({
  Name:{
    type:String,
    required:true
  }, 
  Email:{
    type:String,
    required:true
  },
  Password:{
    type:String,
    required:true
  },
  CustomCategories:{
    type:[CategoryScheme],
    required:true
  },
  Expenses:{
    type:[ExpenseScheme],
    required:true
  },
  totalBalance:{
    type:MoneyScheme,
    required:true
  },
  monthlyIncome:{
    type:MoneyScheme,
    required:true
  },
  monthlyExpense:{
    type:[ExpenseScheme],
    required:true
  },
  PayDay:{
    type:Date,
    required:true
  },
  
  Jwt:{
    type:String,
    required:true
  } 

});

const userModel=db.model('User',UserSchema);
module.exports=userModel;
