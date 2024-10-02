const expsenseRouter = require('express').Router();
const User = require('../../models/userSchema');

expsenseRouter.post('/addExpense', async (req, res) => {
  const jwt=req.body.jwt;
  const user = await User.findOne({Jwt:jwt});
  if (!user){
    res.send('user not found!');

    return;
  }
 User.updateOne({Jwt:jwt},{$push:{Expenses:req.body}});

})
