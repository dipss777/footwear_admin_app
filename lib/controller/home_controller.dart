import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:footware_admin/model/product/product.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  // String test = 'test string';
  // testMethod() {
  //   print(test);
  // }

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference productCollection;

  TextEditingController productNameCtrl = TextEditingController();
  TextEditingController productDescriptionCtrl = TextEditingController();
  TextEditingController productImgCtrl = TextEditingController();
  TextEditingController productPriceCtrl = TextEditingController();

  String category = 'general';
  String brand = 'un branded';
  bool offer = false;

  List<Product> products = [];

  @override
  Future<void> onInit() async {
    productCollection = firestore.collection('products');
    await fetchProducts();
    super.onInit();
  }

  addProduct() {
    try {
      DocumentReference doc = productCollection.doc();
      Product product = Product(
        id: doc.id,
        name: productNameCtrl.text,
        category: category,
        description:productDescriptionCtrl.text,
        price:double.tryParse(productPriceCtrl.text),
        brand: brand,
        image: productImgCtrl.text,
        offer: offer,
      );
      final productJson = product.toJson();
      doc.set(productJson);
      Get.snackbar('Success', 'Product added successfully', colorText: Colors.green);
      setValueDefault();
    } catch (e) {
      Get.snackbar('Error', e.toString(), colorText: Colors.redAccent);
    }
  }

  fetchProducts() async {
    try {
      QuerySnapshot productSnapshot = await productCollection.get();
      final List<Product> retrivedProducts = productSnapshot.docs.map((doc) =>
              Product.fromJson(doc.data() as Map<String, dynamic>)).toList();
      products.clear();
      products.assignAll(retrivedProducts);
      Get.snackbar('Success', 'Product Fetch Successfully', colorText: Colors.green);
    } catch (e) {
      Get.snackbar('Error', e.toString(), colorText: Colors.redAccent);
    } finally {
      update();
    }

  }

  deleteProduct(String id) async {
    try {
      await productCollection.doc(id).delete();
      fetchProducts();
    } catch (e) {
      Get.snackbar('Error', e.toString(), colorText: Colors.red);
      print(e);
    }
  }

  setValueDefault() {
    productNameCtrl.clear();
    productDescriptionCtrl.clear();
    productImgCtrl.clear();
    productPriceCtrl.clear();
    category = 'general';
    brand = 'un branded';
    offer = false;
    update();
  }

}