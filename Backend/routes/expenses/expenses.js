const expsenseRouter = require('express').Router();
const User=require('../../Schemas/userShcema')
expsenseRouter.post('/addExpense', async (req, res) => {
  const jwt=req.body.jwt;
  if (!jwt){
    res.send('provide jwt');
    return
  }
  const user = await User.findOne({Name:"Mouloud24"});
  if (!user){
    res.send('user not found!');

    return;
  }
  if (!req.body.Expense){
    res.send('provide a valid Expense')
    return;
  }
     
  const total=user.totalBalance;
console.log(req.body)
 User.updateOne({Name:"Mouloud24"},{totalBalance:total-req.body.Expense.Amount.Amount})
 const added=User.updateOne({Name:"Mouloud24"},{$push:{Expenses:req.body.Expense}});
  console.log(added)
  res.send('Added Expense')
})
expsenseRouter.get('/Expenses/:jwt',async (req,res)=>{
  const jwt=req.params.jwt.trim();
  if (!jwt){
    res.send('Provide a token')
  }
  console.log(jwt)
  

const user = await User.findOne({ Jwt: jwt });
  console.log(user)
  if(!user){
    res.send('user not found!');
    return;
  }  
  res.json({"expenses":user.Expenses});
})
expsenseRouter.get('/ExpensesByCat/:jwt',async (req,res)=>{
  const category=req.query.category;
  if (!category){
    res.send('No Category')
   return;
  }
  const user=await User.findOne({Jwt:req.params.jwt});
  if (!user){
    res.send('Wrong Token');
    return;
  }
  const tasks=user.Expenses.find({Category:category});
  res.json({"expenses":tasks});
    
  })

module.exports=expsenseRouter;
