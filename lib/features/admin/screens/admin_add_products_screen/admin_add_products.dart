import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/common/widgets/custom_button.dart';
import 'package:flutter_amazon_clone/common/widgets/custom_textfield.dart';
import 'package:flutter_amazon_clone/constants/global_variables.dart';
import 'package:flutter_amazon_clone/constants/utils.dart';
import 'package:flutter_amazon_clone/features/admin/services/admin_services.dart';

class AdminAddProducts extends StatefulWidget {
  static const String routName = "/add-product";
  const AdminAddProducts({super.key});

  @override
  State<AdminAddProducts> createState() => _AdminAddProductsState();
}

class _AdminAddProductsState extends State<AdminAddProducts> {
  //instance of admin service
  final AdminServices _adminServices = AdminServices();

  //global key for varidation
  final _addProductFormKey = GlobalKey<FormState>();

  //controllers
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _productDescriptionController =
      TextEditingController();
  final TextEditingController _productPriceController = TextEditingController();
  final TextEditingController _productQuantityController =
      TextEditingController();
  final TextEditingController _productCategoryController =
      TextEditingController();

  //category variable
  String category = "Mobiles";

  //dropdown list of categories list.
  List<String> categories = [
    "Mobiles",
    "Essentials",
    "Appliances",
    "Electronics",
    "Books",
    "Fashion",
  ];

  //list of images
  List<File> images = [];

  //function to select images and add to the list
  void selectImages() async {
    var res = await pickImages();
    setState(() {
      images = res;
    });
  }

  //function to add product to the database
  void sellProduct() {
    if (_addProductFormKey.currentState!.validate() && images.isNotEmpty) {
      _adminServices.sellProduct(
          context: context,
          productName: _productNameController.text,
          productDescription: _productDescriptionController.text,
          productPrice: double.parse(_productPriceController.text),
          productQuantity: int.parse(_productQuantityController.text),
          productCategory: category,
          images: images);
    }
  }

  //dispose method to dispose the controllers to avoid memory leaks
  @override
  void dispose() {
    super.dispose();
    _productNameController.dispose();
    _productDescriptionController.dispose();
    _productPriceController.dispose();
    _productQuantityController.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration:
                const BoxDecoration(gradient: GlobalVariables.appBarGradient),
          ),
          title: const Text(
            "Add Product",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
            key: _addProductFormKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  //sized box for spacing
                  const SizedBox(
                    height: 20,
                  ),
                  //image selector
                  GestureDetector(
                    onTap: selectImages,
                    child: images.isNotEmpty
                        ? CarouselSlider(
                            items: images.map((i) {
                              return Builder(
                                  builder: (BuildContext context) => Image.file(
                                        i,
                                        fit: BoxFit.cover,
                                        height: 200,
                                      ));
                            }).toList(),
                            options: CarouselOptions(
                              viewportFraction: 1,
                              height: 200,
                              autoPlay: true,
                            ),
                          )
                        : DottedBorder(
                            borderType: BorderType.RRect,
                            radius: const Radius.circular(10),
                            dashPattern: const [10, 4],
                            strokeCap: StrokeCap.round,
                            strokeWidth: 2,
                            child: Container(
                              width: double.infinity,
                              height: 150,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.folder_open,
                                    size: 40,
                                  ),
                                  //sized box for spacing
                                  const SizedBox(height: 15),

                                  Text(
                                    "Select Product Images",
                                    style: TextStyle(color: Colors.grey[500]),
                                  )
                                ],
                              ),
                            )),
                  ),
                  //sized box for spacing
                  const SizedBox(
                    height: 40,
                  ),

                  //product name
                  CustomTextfield(
                    controller: _productNameController,
                    hintText: "Product Name",
                  ),
                  //sized box for spacing
                  const SizedBox(
                    height: 10,
                  ),
                  //product description
                  CustomTextfield(
                    controller: _productDescriptionController,
                    hintText: "Description",
                    maxLines: 5,
                  ),
                  //sized box for spacing
                  const SizedBox(
                    height: 10,
                  ),
                  //product price
                  CustomTextfield(
                    controller: _productPriceController,
                    hintText: "Price",
                  ),
                  //sized box for spacing
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextfield(
                    controller: _productQuantityController,
                    hintText: "Quantity",
                  ),
                  //sized box for spacing
                  const SizedBox(
                    height: 10,
                  ),

                  SizedBox(
                    width: double.infinity,
                    child: DropdownButton(
                      hint: const Text("Select Category"),
                      value: category,
                      icon: const Icon(Icons.arrow_downward),
                      items: categories.map((String item) {
                        return DropdownMenuItem(value: item, child: Text(item));
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          category = newValue!;
                        });
                      },
                    ),
                  ),
                  //sized box for spacing
                  const SizedBox(
                    height: 20,
                  ),
                  //add a sell button
                  CustomButton(text: "Sell", onTap: sellProduct),
                ],
              ),
            )),
      ),
    );
  }
}
