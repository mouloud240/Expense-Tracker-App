const userModel = require('../../Schemas/userShcema');
const authMiddlware = require('../middlewares/authMiddlware');

const categoriesRouter=require('express').Router()

categoriesRouter.get("/categories",authMiddlware,async(req,res)=>{
  const User=req.user
  const user=await userModel.findById(User.UserId)
  if (!user){
    res.send('User not found')
    return
  }
  res.json({
    status:"Found categories",
    categories:user.CustomCategories
  })
})

categoriesRouter.post('/categories',authMiddlware,async (req,res)=>{
  const category=req.body;
  const User=req.user;
  
  if (!category){
    res.send('Provide a body');
    return;
  }
  const user=await userModel.findById(User.UserId);
  if (!user){
    return res.send('User not found')
  }
   const cat=user.CustomCategories.find(item=>item.Name==category.Name);
  if (cat){
    res.send('Category Already Exists')
  }
  await userModel.updateOne({_id:User.UserId},{$push:{CustomCategories:category}})

  res.send('Added new Category')
})


categoriesRouter.put('/categoriesLimit',authMiddlware,async (req,res)=>{
  const category=req.body;
  const User=req.user;
  const categoryId=category._id
    if (!category){
    res.send('Provide a category');
    return;
  }

  try {
  await userModel.findOneAndUpdate({_id:User.UserId,"CustomCategories._id":categoryId},{
$set:{
      "CustomCategories.$.Name":category.Name,
      "CustomCategories.$.Budget":category.Budget,
    },
  
  })
   
  } catch (error) {
  res.send(error)
    return
  }
  res.send('Updated succefully')
  return;

})



categoriesRouter.put('/SetCategorieLimit',authMiddlware,async(req,res)=>{
  const User=req.user;
  const id=req.body.id
   
try {
  await userModel.findOneAndUpdate({_id:User.UserID,"CustomCategories._id":id},{
$set:{
      "CustomCategories.$.Budget":category.Budget,
    },
  
  })
} catch (err) {
    res.statusCode(400).send(err);
    return;
  
}
  res.send('Updated limit succefully')
})

categoriesRouter.delete('/categories',authMiddlware,async(req,res)=>{
  const User=req.user;
  const id=req.query.id;
  console.log(id)
  if (!id){
    return res.send('Provide a category id');
  }
  let  user=await userModel.findById(User.UserId);
  if (!user){
    res.send('User not found')
    return;
  }
 user.CustomCategories= user.CustomCategories.filter((item) =>item._id.toString()!=id )
  console.log(user.CustomCategories.length)
try {
  
  await user.save()  
} catch (error) {
 res.send("Error") 
    return;
}  
  res.send("Category Deleted")
  
  })



module.exports=categoriesRouter;
