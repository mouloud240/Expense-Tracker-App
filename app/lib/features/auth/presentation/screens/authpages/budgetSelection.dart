import 'package:app/config/colors.dart';
import 'package:app/core/currencies.dart';
import 'package:app/features/auth/presentation/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Budgetselection extends StatefulWidget {
  const Budgetselection({super.key});

  @override
  State<Budgetselection> createState() => _BudgetselectionState();
}

class _BudgetselectionState extends State<Budgetselection> {
  final currencyList=Currencies.currenciesMap;
  late int money;
  late String _selectedCurrency;
  late TextEditingController moneyController;
  @override
    void initState() {
      super.initState();
      money=0;
      moneyController=TextEditingController(text: money.toString());
      _selectedCurrency="USD";
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 65.h,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_sharp,color: Colors.white,),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Add New Account',style: TextStyle(color: Colors.white,fontSize: 18.sp,fontWeight: FontWeight.w600),),
        backgroundColor: Appcolors.violet100,
        centerTitle: true,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
       decoration: BoxDecoration(
          color: Appcolors.violet100
            
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 312.h,
        
              ),
              Padding(
                padding: EdgeInsets.only(left:16.w),
                child: Text("Balance",style: TextStyle(color: Colors.grey,fontSize: 23.sp,fontWeight: FontWeight.w600),),
              
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.w),
                child: Text("$money.0$_selectedCurrency",style: TextStyle(color: Appcolors.light100,fontSize: 64.sp,fontWeight: FontWeight.w500),),
              )
            ,
              Expanded(
                child: Container(
                    width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:BorderRadius.only(topLeft: Radius.circular(30.r,),topRight: Radius.circular(30.r)) 
                  ),
                  child: Column(
                  mainAxisSize: MainAxisSize.min,
                children: [
                  const Spacer(),
             Row(
                               mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                
    width: 137.w,
                          child: Field(controller: moneyController, hintText: "Amount", validator: (val)=>null)),
                       
    GestureDetector(
                          onTap:(){
                            setState(() {
                              money=int.parse(moneyController.text);
                            });
                          } ,
      child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 10.h),
                  decoration: BoxDecoration(
                                      color: Appcolors.green100,
                     borderRadius: BorderRadius.circular(10.r)
                            ),
                            child: Text("Submit",style: TextStyle(
                              color: Colors.white,fontWeight: FontWeight.w600,fontSize: 16.sp
                            ),),),
    ),
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              moneyController.text="0";
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 10.h),
                             decoration: BoxDecoration(
                              color: Appcolors.red100,
                              borderRadius: BorderRadius.circular(10.r)
                            )
                          ,child: Text("Reset",style: TextStyle(
                              color: Colors.white,fontWeight: FontWeight.w600,fontSize: 16.sp
                            ),),),
                        )
                      ],
                      
             )  ,
     const Spacer(),       
                    DropdownMenu(
                      hintText: "Select Currency",
                       
                      menuStyle:  MenuStyle(
                     side:WidgetStatePropertyAll(BorderSide(
                          color: Appcolors.light40
                           
                  )),
                        elevation: const WidgetStatePropertyAll(0),
                        backgroundColor: WidgetStatePropertyAll(Appcolors.light40),
                                            ),
                     inputDecorationTheme:  InputDecorationTheme(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color:Appcolors.light40,width: 2),
                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                        ),
                        border: const OutlineInputBorder(
                          
                          borderSide: BorderSide(color:Colors.red),
                          
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      
                      leadingIcon: const Icon(Icons.monetization_on_sharp),
                      trailingIcon: const Icon(Icons.arrow_drop_down),
                      width: 343.w,
                    onSelected: (value)=>{
                      setState((){
                        _selectedCurrency=value??"USD";
                      })
                      },  
              dropdownMenuEntries: const [

               DropdownMenuEntry(value: "USD", label: "American Dollar",
                        ),  
DropdownMenuEntry(value: "DZD", label: "Algerian Dinar",
                        ),
DropdownMenuEntry(value: "EUR", label: "Euro",
                        ),
                      ],        
                    ),
                   const Spacer(flex: 2,), 
                    ElevatedButton(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(Appcolors.violet100),
            shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r))),
                        minimumSize: WidgetStateProperty.all(Size(343.w, 50.h)),
                      ),
                      onPressed: (){}, child: Text("Continue",style: TextStyle(color: Colors.white,fontWeight:FontWeight.w600,fontSize:18.sp ),)),
                      const Spacer()
                    ], 
                  ),
                ),
              ),
        
            ],
          ),
      ));
  }
}
