import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(Page3());
}

class Page3 extends StatefulWidget{
  @override
  _Page3State createState()=> _Page3State() ;

}

class _Page3State extends State<Page3> {
  final TextEditingController priceController = TextEditingController();
  final TextEditingController priceController2 = TextEditingController();
  final TextEditingController discountController = TextEditingController();
  final TextEditingController vatController = TextEditingController();
   double product1 =0.0;
   double finalPrice =0.0;
  double discountAmount = 0.0;
  double vatAmount = 0.0;

  void calculatPrice(){
    setState(() {
      //get values from controller
      double price1=double.tryParse(priceController.text)??0.0;
      double price2=double.tryParse(priceController2.text)??0.0;
      double discount = double.tryParse(discountController.text) ?? 0.0;
      double vat = double.tryParse(vatController.text)??0.0;

      // calculate vat and discount
      discountAmount =(price1*discount)/100;
      double discountedPrice = price1 - discountAmount;
      vatAmount = (discountedPrice*vat)/100;

      //final price
      finalPrice = discountedPrice + vatAmount;
    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(title: Text('Product price calculator')),
        body:Padding(
            padding:const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //product price input
              TextField(
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Product price',
                  border: OutlineInputBorder(),
                ),

              ),
              SizedBox(height: 16),
              // Discount input
              TextField(
                controller: discountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Discount (%)',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              // VAT input
              TextField(
                controller: vatController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'VAT (%)',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              // Calculate button
              ElevatedButton(
                onPressed: calculatPrice,
                child: Text('Calculate Price'),
              ),
              SizedBox(height: 16),

              //display result
              Text('discount Amount : \BDT ${discountAmount.toStringAsFixed(2)}'),
              Text('Vat Amount : \BDT ${vatAmount.toStringAsFixed(2)}'),
              Text('Final Price (Include VAT) :\BDT ${finalPrice.toStringAsFixed(2)}'),
              ElevatedButton(onPressed: (){
                Navigator.pop(context);
              }, child: Icon(Icons.arrow_back)),

              ElevatedButton(onPressed: (){
                Navigator.pushNamed(context, 'page4');
              }, child: Icon(Icons.next_plan_outlined)),

            ],

          ),
        ),




    );
  }
}