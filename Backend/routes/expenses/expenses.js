const userModel = require('../../Schemas/userShcema');
const authMiddlware = require('../middlewares/authMiddlware');
const expsenseRouter = require('express').Router();
expsenseRouter.post('/addExpense',authMiddlware ,async (req, res) => {
   const User=req.user
  
  const user = await userModel.findById(User.UserId);
  if (!user){
    res.send('user not found!');
    return;
  }
  if (!req.body.Expense){
    res.send('provide a valid Expense')
    return;
  }
  try{
 const total=user.totalBalance;
    const newTotal={Amount: total.Amount-req.body.Expense.Amount.Amount,Currency:total.Currency};
    console.log(total)
 await userModel.updateOne({_id:User.UserId},{$set:{ totalBalance:newTotal }})
 await userModel.updateOne({_id:User.UserId},{$push:{Expenses:req.body.Expense}});
  const newUser=await userModel.findById(User.UserId);
  res.json({
    status:"Added an expenses",
    newBalance:newUser.totalBalance
  })

  }catch(err){
    console.log(err)
    res.send('Invalid Expense')
    return;
  }
 })
expsenseRouter.get('/Expenses',authMiddlware,async (req,res)=>{
  const User=req.user

const user = await userModel.findById(User.UserId)
  if(!user){
    res.send('user not found!');
    return;
  }  
  res.json({"expenses":user.Expenses});
})
expsenseRouter.get('/ExpensesByCat',authMiddlware,async (req,res)=>{
  const category=req.query.category;
 const User=req.user; 
  if (!category){
    res.send('No Category')
   return;
  }
  const user=await userModel.findById(User.UserId);
  if (!user){
    res.send('Wrong Token');
    return;
  }
  const expenses=user.Expenses.find(exp=>exp.Category.Name==category);
  res.json({"expenses":expenses});
    
  })
expsenseRouter.delete("/Expense",authMiddlware, async(req,res)=>{
  const id=req.query.id;
  const User=req.user;
  if (!id){
    res.send('Provide an id')
  }
  let user=await userModel.findById(User.UserId);
  if (!user){
    res.send('User Not found');
    return;
  }
  const expenseAmount=user.Expenses.find(exp=>exp._id.toString()==id).Amount.Amount
  if (!expenseAmount){
    res.send('Expense not found')
    return;
  }
  try {
     
      user.Expenses = user.Expenses.filter(expense => expense._id.toString() !== id);
    user.totalBalance={Amount:user.totalBalance.Amount+expenseAmount,Currency:user.totalBalance.Currency}
    await user.save()
    res.json({
      status:"Deleted expense",
      newAmount:user.totalBalance
    })
       
  } catch (error) {
    console.log(error);
      res.status(500).send('Failed to delete Expense')
  }


})
expsenseRouter.get('/Expense',authMiddlware,async(req,res)=>{
  const id=req.query.id;
  const User=req.user;
  if (!id){
    res.send('Provide an id')
  }
  const user=await userModel.findById(User.UserId);
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
expsenseRouter.delete('/ExpensesAll',authMiddlware,async (req,res)=>{
  const User=req.user;
  const user=await userModel.findById(User.UserId);
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
expsenseRouter.put('/budget',authMiddlware,async(req,res)=>{
 const {Amount,Currency}=req.body;
  const User=req.user;
  if (!Amount){
    res.send('Provide an Amount')
    return;
  }
  if (!Currency){
    res.send('Provide a Currency')
    return;
  }
  let updatedUser=null
  try{

  updatedUser=await userModel.findOneAndUpdate({_id:User.UserId},{$set:{totalBalance:{Amount:Amount,Currency:Currency}}},{new:true})    
  } catch(err){
   res.send(err)
   return;
 }
  if (!updatedUser){
    res.status(200).send('Unknown Error!')
  }
 return res.send(updatedUser)
})

module.exports=expsenseRouter;
