import 'package:app/config/colors.dart';
import 'package:flutter/material.dart';

class addExpenseScreen extends StatefulWidget {
  const addExpenseScreen({super.key});

  @override
  State<addExpenseScreen> createState() => _addExpenseScreenState();
}

class _addExpenseScreenState extends State<addExpenseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: false,
              expandedHeight: 120,
              flexibleSpace: const FlexibleSpaceBar(
                title: Text(
                  "Add Task",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
                centerTitle: true,
              ),
              leading: IconButton(
                style: ButtonStyle(
                    backgroundColor: const WidgetStatePropertyAll(Colors.white),
                    shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)))),
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Appcolors.red80,
                ),
              ),
              backgroundColor: Appcolors.red80,
            ),
            SliverToBoxAdapter(
              child: Container(
                decoration: BoxDecoration(
                  color: Appcolors.blue80,
                ),
                child: Container(
                  padding: const EdgeInsets.all(15),
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        )
    );
  }
}
