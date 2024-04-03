import 'package:flutter/material.dart';
import 'package:footware_admin/controller/home_controller.dart';
import 'package:footware_admin/widgets/drop_down_btn.dart';
import 'package:get/get.dart';

class AddProductPage extends StatelessWidget {
  const AddProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (ctrl) {
      return Scaffold(
        appBar: AppBar(title: Text('Add Product'),),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(10),
            width: double.maxFinite,
            child: Column(
              children: [
                Text('Add New Product', style: TextStyle(fontSize: 30,
                    color: Colors.indigoAccent,
                    fontWeight: FontWeight.bold),),
                TextField(
                  controller: ctrl.productNameCtrl,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    label: Text('Product Name'),
                    hintText: 'Enter Your Product Name',
                  ),
                ),
                SizedBox(height: 10,),
                TextField(
                  controller: ctrl.productDescriptionCtrl,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    label: Text('Product Description'),
                    hintText: 'Enter Your Product Description',
                  ),
                  maxLines: 4,
                ),
                SizedBox(height: 10,),
                TextField(
                  controller: ctrl.productImgCtrl,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    label: Text('Image URL'),
                    hintText: 'Enter Your Product Image URL',
                  ),
                ),
                SizedBox(height: 10,),
                TextField(
                  controller: ctrl.productPriceCtrl,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    label: Text('Product Price'),
                    hintText: 'Enter Your Product Price',
                  ),
                ),
                SizedBox(height: 10,),
                Row(
                  children: [
                    Flexible(
                        child: DropDownBtn(items: ['Boots', 'Shoe', 'Beach Shoes','High Heels', 'Slippers'],
                          seletedItemText: ctrl.category,
                          onSelected: (selectedValue) {
                            ctrl.category = selectedValue ?? 'general';
                            ctrl.update();
                          },
                        )),
                    Flexible(child: DropDownBtn(
                      items: ['Puma', 'Adidas', 'Sparx', 'Clarks', 'Bata'],
                      seletedItemText: ctrl.brand,
                      onSelected: (selectedValue) {
                        ctrl.brand = selectedValue ?? 'un branded';
                        ctrl.update();
                      },
                    )),
                  ],
                ),
                SizedBox(height: 10,),
                Text('Offer Product?'),
                DropDownBtn(
                  items: ['true', 'false'],
                  seletedItemText: ctrl.offer.toString(),
                  onSelected: (selectedValue) {
                    ctrl.offer = bool.tryParse(selectedValue ?? 'false') ?? false;
                    ctrl.update();
                  },
                ),
                SizedBox(height: 10,),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigoAccent,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      ctrl.addProduct();
                    },
                    child: Text('Add Product')),
              ],
            ),
          ),
        ),
      );
    });
  }
}
