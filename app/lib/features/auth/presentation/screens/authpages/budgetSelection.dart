import 'package:app/config/colors.dart';
import 'package:app/core/currencies.dart';
import 'package:app/features/auth/presentation/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
      moneyController=TextEditingController(text: money.toString());
      money=0;
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
                child: Text("Balance",style: TextStyle(color: Colors.grey,fontSize: 22.sp,fontWeight: FontWeight.w500),),
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
                    //To style Later
             Row(
                               mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                
    width: 137.w,
                          child: Field(controller: moneyController, hintText: "Amount", validator: (val)=>null)),
                       
    GestureDetector(
                          onTap:(){
                            print(int.parse(moneyController.text));
                          } ,
      child: Container(
        color: Appcolors.green100,
                            child: Text("Submit"),),
    ),
                        Container(
color: Appcolors.red100
                        ,child: Text("Reset"),)
                      ],
                      
             )  ,
            
                    DropdownMenu(
                      hintText: "Select Currency",
                       
                      menuStyle:  MenuStyle(
                     side:WidgetStatePropertyAll(BorderSide(
                          color: Appcolors.light40
                           
                  )),
                        elevation: WidgetStatePropertyAll(0),
                        backgroundColor: WidgetStatePropertyAll(Appcolors.light40),
                                            ),
                     inputDecorationTheme:  const InputDecorationTheme(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color:Colors.grey),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        border: OutlineInputBorder(
                          
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
              dropdownMenuEntries: [

               const DropdownMenuEntry(value: "USD", label: "American Dollar",
                        ),  
const DropdownMenuEntry(value: "DZD", label: "Algerian Dinar",
                        ),
const DropdownMenuEntry(value: "EUR", label: "Euro",
                        ),
                      ],        
                    ),
                    ElevatedButton(onPressed: (){}, child: Text("Continue"))
                    ], 
                  ),
                ),
              ),
        
            ],
          ),
      ));
  }
}
