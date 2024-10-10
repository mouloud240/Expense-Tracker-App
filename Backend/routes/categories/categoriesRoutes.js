const userModel = require('../../Schemas/userShcema');

const categoriesRouter=require('express').Router()

categoriesRouter.get("/categories/:jwt",async(req,res)=>{
  const jwt=req.params.jwt
  if (!jwt){
    res.send('Provide a token')
  return;
  }
  const user=await userModel.findOne({Jwt:jwt})
  if (!user){
    res.send('User not found')
    return
  }
  res.json({
    status:"Found categories",
    categories:user.CustomCategories
  })
})

categoriesRouter.post('/categories/:jwt',async (req,res)=>{
  const category=req.body;
  const jwt=req.params.jwt;
  console.log(category)
  if (!jwt){
    res.send('Provide a valid token')
    
    return
  }
  if (!category){
    res.send('Provide a body');
    return;
  }
  const user=await userModel.findOne({Jwt:jwt});
  if (!user){
    return res.send('User not found')
  }
   const cat=user.CustomCategories.find(item=>item.Name==category.Name);
  if (cat){
    res.send('Category Already Exists')
  }
  await userModel.updateOne({Jwt:jwt},{$push:{CustomCategories:category}})

  res.send('Added new Category')
})


categoriesRouter.put('/categoriesLimit/:jwt',async (req,res)=>{
  const category=req.body;
  const jwt=req.params.jwt;
  const categoryId=category._id
  if (!jwt){
    res.send('Provide a jwt')
    return;
  }
  if (!category){
    res.send('Provide a category');
    return;
  }

  try {
  await userModel.findOneAndUpdate({Jwt:jwt,"CustomCategories._id":categoryId},{
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



categoriesRouter.put('/SetCategorieLimit/:jwt',async(req,res)=>{
  const jwt=req.params.jwt;
  const id=req.body.id
   
try {
  await userModel.findOneAndUpdate({Jwt:jwt,"CustomCategories._id":id},{
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

categoriesRouter.delete('/categories/:jwt',async(req,res)=>{
  const jwt=req.params.jwt;
  const id=req.query.id;
  console.log(id)
  if (!jwt){
    return res.send('Provide a token');
  }
  if (!id){
    return res.send('Provide a category id');
  }
  let  user=await userModel.findOne({Jwt:jwt});
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
