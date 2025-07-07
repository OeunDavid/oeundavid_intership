import 'package:flutter/material.dart';
import 'package:products/core/constants/app_color.dart';
import 'package:products/core/constants/imagepath.dart';
import 'package:products/providers/addproduct_provider.dart';
import 'package:products/views/widgets/textfield_widget.dart';
import 'package:provider/provider.dart';

class AddproductScreen extends StatefulWidget {
  const AddproductScreen({super.key});

  @override
  State<AddproductScreen> createState() => _AddproductScreenState();
}

class _AddproductScreenState extends State<AddproductScreen> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AddproductProvider>(context);
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(),
        body: Form(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 90,
                        child:
                            TextfieldWidget(
                              label: 'Product Name',
                              hintText: 'Enter product name',
                              controller: provider.nameController,
                              pathIcon: AppIcon.profile,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter product name';
                                }
                                return null;
                              },
                            ).build(),
                      ),
                      SizedBox(
                        height: 90,
                        child:
                            TextfieldWidget(
                              label: 'Product Price',
                              hintText: 'Enter product price',
                              controller: provider.priceController,
                              pathIcon: AppIcon.currency,
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter product price';
                                }
                                if (double.tryParse(value) == null) {
                                  return 'Please enter a valid price';
                                }
                                return null;
                              },
                            ).build(),
                      ),
                      SizedBox(
                        height: 90,
                        child:
                            TextfieldWidget(
                              label: 'Product Stock',
                              hintText: 'Enter product stock',
                              controller: provider.stockController,
                              pathIcon: AppIcon.stock,
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter product stock';
                                }
                                if (int.tryParse(value) == null) {
                                  return 'Please enter a valid stock';
                                }
                                return null;
                              },
                            ).build(),
                      ),
                      const SizedBox(height: 12),
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
                              provider.addProduct(); // safe now
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
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(
        'Add Product',
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
