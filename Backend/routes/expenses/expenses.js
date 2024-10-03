const expsenseRouter = require('express').Router();
const { Router } = require('express');
const User=require('../../Schemas/userShcema')
expsenseRouter.post('/addExpense', async (req, res) => {
  const jwt=req.body.jwt;
  if (!jwt){
    res.send('provide jwt');
    return
  }
  const user = await User.findOne({Jwt:jwt});
  if (!user){
    res.send('user not found!');

    return;
  }
  if (!req.body.Expense){
    res.send('provide a valid Expense')
    return;
  }
     
  const total=user.totalBalance;
 await User.updateOne({Jwt:jwt},{$set:{ totalBalance:total-req.body.Expense.Amount.Amount }})
 await User.updateOne({Jwt:jwt},{$push:{Expenses:req.body.Expense}});
  const newUser=await User.findOne({Jwt:jwt})
  res.json({
    status:"Added an expenses",
    newBalance:newUser.totalBalance
  })
})
expsenseRouter.get('/Expenses/:jwt',async (req,res)=>{
  const jwt=req.params.jwt.trim();
  if (!jwt){
    res.send('Provide a token')
  }
  

const user = await User.findOne({ Jwt: jwt });
  if(!user){
    res.send('user not found!');
    return;
  }  
  res.json({"expenses":user.Expenses});
})
expsenseRouter.get('/ExpensesByCat/:jwt',async (req,res)=>{
  const category=req.query.category;
  const jwt=req.params.jwt;
  if (!jwt){
    res.send('Provide a token')
    return;
  }
  if (!category){
    res.send('No Category')
   return;
  }
  const user=await User.findOne({Jwt:jwt});
  if (!user){
    res.send('Wrong Token');
    return;
  }
  const expenses=user.Expenses.find(exp=>exp.Category==category);
  res.json({"expenses":expenses});
    
  })
expsenseRouter.delete("/Expense/:jwt", async(req,res)=>{
  const id=req.query.id;
  const jwt=req.params.jwt;
  if (!id){
    res.send('Provide an id')
  }
  if (!jwt){
    res.send('Provide a Valid Token')
  }
  let user=await User.findOne({Jwt:jwt})
  if (!user){
    res.send('User Not found');
    return;
  }
  const expenseAmount=user.Expenses.find(exp=>exp._id.toString()==id).Amount.Amount
  if (!expenseAmount){
    res.send('Expense Error') //remove Later
    return;
  }
  try {
     
      user.Expenses = user.Expenses.filter(expense => expense._id.toString() !== id);
    user.totalBalance+=expenseAmount
    await user.save()
    res.json({
      status:"Delete expense",
      newAmount:user.totalBalance
    })
       
  } catch (error) {

    res.status(500).send('Failed to delete Expense')
  }


})
expsenseRouter.get('/Expense/:jwt',async(req,res)=>{
  const jwt=req.params.jwt;
  const id=req.query.id;
  if (!id){
    res.send('Provide an id')
  }
  if (!jwt){
    res.send('Provide a Valid Token')
  }
  const user=await User.findOne({Jwt:jwt})
  if (!user){
    res.send('User not found')
    return;
  }
  const expense=user.Expenses.find(exp=>exp._id==id)
  if (!expense){
    res.send('Expense not Found')
    return;
  }
  res.json(expense)
  
})
expsenseRouter.delete('/ExpensesAll/:jwt',async (req,res)=>{
  const jwt=req.params.jwt;
  if (!jwt){
    res.send('Provide a jwt')
    return;
  }
  const user=await User.findOne({Jwt:jwt})

  if (!user){
    res.send('User not found');
    return;
  }
  let total=0 
  user.Expenses.map((item)=>{total+=item.Amount.Amount},)
  console.log(total)
  user.totalBalance+=total
user.Expenses=[]
await user.save()
res.json({
    status:"Deleted All",
    newBalace:user.totalBalance
  })
})

module.exports=expsenseRouter;
