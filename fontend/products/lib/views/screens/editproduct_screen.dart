import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:products/core/constants/app_color.dart';
import 'package:products/core/constants/imagepath.dart';
import 'package:products/models/product_model.dart';
import 'package:products/providers/edit_product_provider.dart';
import 'package:products/views/widgets/textfield_widget.dart';
import 'package:provider/provider.dart';

class EditproductScreen extends StatefulWidget {
  const EditproductScreen({super.key});

  @override
  State<EditproductScreen> createState() => _EditproductScreenState();
}

class _EditproductScreenState extends State<EditproductScreen> {
  final _formKey = GlobalKey<FormState>();
  late ProductModel product;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    product = ModalRoute.of(context)!.settings.arguments as ProductModel;

    final provider = Provider.of<EditProductProvider>(context, listen: false);
    provider.nameController.text = product.productName;
    provider.priceController.text = product.prices.toString();
    provider.stockController.text = product.stock.toString();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<EditProductProvider>(context);
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(),
        body: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.sizeOf(context).height * 0.3,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColor.cardBackground,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: AppColor.primary.withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                    child: Image.asset(AppIcon.headphone, fit: BoxFit.contain),
                  ),
                  SizedBox(height: 16),
                  TextfieldWidget(
                    label: 'Product Name',
                    hintText: 'Enter new product name',
                    controller: provider.nameController,
                    pathIcon: AppIcon.profile,
                  ).build(),
                  TextfieldWidget(
                    label: 'Product Price',
                    hintText: 'Enter new product price',
                    controller: provider.priceController,
                    pathIcon: AppIcon.profile,
                    keyboardType: TextInputType.number,
                  ).build(),
                  TextfieldWidget(
                    label: 'Product Stock',
                    hintText: 'Enter new product stock',
                    controller: provider.stockController,
                    pathIcon: AppIcon.stock,
                    keyboardType: TextInputType.number,
                  ).build(),
                  SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          bool updated = await provider.editProduct(product);
                          if (updated && context.mounted) {
                            Navigator.pop(context, true);
                            MotionToast.success(
                              title: Text("Success"),
                              description: Text(
                                "Product updated successfully!",
                              ),
                            ).show(context);
                          } else {
                            MotionToast.error(
                              title: Text("Error"),
                              description: Text(
                                "Failed to update product. Please try again.",
                              ),
                            ).show(context);
                          }
                        }
                      },
                      child: const Text(
                        'Add Product',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(
        'Edit Product',
        style: TextStyle(
          color: AppColor.background,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Navigator.pop(context, true),
      ),
      elevation: 1,
      backgroundColor: Colors.transparent,
      toolbarHeight: 96,
      iconTheme: IconThemeData(color: AppColor.cardBackground),
      flexibleSpace: ClipRRect(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
        child: Container(color: AppColor.primary),
      ),
    );
  }
}
