import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/constants/global_variables.dart';
import 'package:flutter_amazon_clone/features/admin/models/product_model.dart';
import 'package:flutter_amazon_clone/features/admin/screens/admin_add_products_screen/admin_add_products.dart';
import 'package:flutter_amazon_clone/features/admin/services/admin_services.dart';
import 'package:flutter_amazon_clone/features/screens/account/widgets/single_product.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  //List of products
  List<Product>? products;
  //instance of adminService
  final AdminServices adminServices = AdminServices();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchAllProducts();
  }

  //getting all the products
  fetchAllProducts() async {
    products = await adminServices.fetchAllProducts(context);
    setState(() {});
  }

  //delete products
  void deleteProduct(Product product, int index) {
    adminServices.deleteProduct(
      context: context,
      product: product,
      onSuccess: () {
        products!.removeAt(index);
        setState(() {});
      },
    );
  }

  //show dialog to confirm deleting a product
  void showDeleteDialog(Product product, int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Delete Product"),
            content: Wrap(
              children: [
                const Text("Are you sure you want to delete "),
                Text(
                  product.name,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.red),
                )
              ],
            ),
            actions: [
              InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    color: Colors.white,
                    child: const Text("Cancel"),
                  )),
              InkWell(
                  onTap: () {
                    deleteProduct(product, index);
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      "Delete",
                      style: TextStyle(color: Colors.white),
                    ),
                  )),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    //navigating to the add products page.
    void navigateToAddProductsScreen() {
      Navigator.pushNamed(context, AdminAddProducts.routName);
    }

    return products == null
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: PreferredSize(
                preferredSize: const Size.fromHeight(50),
                child: AppBar(
                  flexibleSpace: Container(
                    decoration: const BoxDecoration(
                        gradient: GlobalVariables.appBarGradient),
                  ),
                  title: Row(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        child: Image.asset(
                          'assets/images/amazon_in.png',
                          width: 120,
                          height: 45,
                          color: Colors.black,
                        ),
                      ),
                      const Spacer(),
                      const Text(
                        "Admin",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                )),
            body: GridView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.only(top: 5, left: 5),
                itemCount: products!.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (context, index) {
                  final productData = products![index];
                  return Column(children: [
                    SizedBox(
                        height: 140,
                        child: SingleProduct(
                          image: productData.images[0],
                        )),
                    Container(
                      height: 30,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: Text(
                              productData.name,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                          IconButton(
                            onPressed: () =>
                                showDeleteDialog(productData, index),
                            icon: Icon(
                              Icons.delete,
                              size: 18,
                              color: Colors.grey[500],
                            ),
                          )
                        ],
                      ),
                    )
                  ]);
                }),
            floatingActionButton: FloatingActionButton(
              onPressed: navigateToAddProductsScreen,
              tooltip: "Add a Product",
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: const BoxDecoration(
                    gradient: GlobalVariables.appBarGradient,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: const Icon(
                  Icons.add,
                  color: GlobalVariables.backgroundColor,
                ),
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
