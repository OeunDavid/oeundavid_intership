import 'package:floating_draggable_widget/floating_draggable_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:products/core/constants/app_color.dart';
import 'package:products/core/constants/imagepath.dart';
import 'package:products/providers/product_providers.dart';
import 'package:products/routes/route_name.dart';
import 'package:products/views/widgets/dialog_widget.dart';
import 'package:products/views/widgets/product_card.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProductProviders>(context, listen: false).fetchProducts();
    });
  }

  Future<void> _refresh() async {
    await Provider.of<ProductProviders>(context, listen: false).fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    final productprovider = Provider.of<ProductProviders>(context);
    return SafeArea(
      child: FloatingDraggableWidget(
        floatingWidget: FloatingActionButton(
          onPressed:
              () => productprovider.navigateToAddProductAndRefresh(context),
          backgroundColor: AppColor.primary.withOpacity(0.8),
          child: SvgPicture.asset(
            AppIcon.plus,
            color: Colors.white,
            width: 48,
            height: 48,
          ),
        ),
        floatingWidgetWidth: 56,
        floatingWidgetHeight: 56,
        mainScreenWidget: Scaffold(
          backgroundColor: Colors.white,
          appBar: _buildAppBar(),
          body:
              productprovider.isLoading
                  ? Center(child: const CircularProgressIndicator())
                  : RefreshIndicator(
                    onRefresh: _refresh,
                    child: NotificationListener<ScrollNotification>(
                      onNotification: (scrollInfo) {
                        if (!productprovider.isLoading &&
                            productprovider.hasMore &&
                            scrollInfo.metrics.pixels ==
                                scrollInfo.metrics.maxScrollExtent) {
                          productprovider.fetchProducts();
                        }
                        return false;
                      },
                      child:
                          productprovider.products.isEmpty
                              ? Center(
                                child: Text(
                                  "No products in stock",
                                  style: TextStyle(
                                    color: AppColor.primary,
                                    fontSize: 16,
                                  ),
                                ),
                              )
                              : ListView.builder(
                                padding: const EdgeInsets.all(16),
                                itemCount:
                                    productprovider.products.isEmpty
                                        ? 1
                                        : productprovider.products.length +
                                            (productprovider.hasMore ? 1 : 0),
                                itemBuilder: (context, index) {
                                  if (index < productprovider.products.length) {
                                    if (index ==
                                        productprovider.products.length) {
                                      WidgetsBinding.instance
                                          .addPostFrameCallback((_) {
                                            productprovider.fetchProducts();
                                          });

                                      return const Padding(
                                        padding: EdgeInsets.all(16),
                                        child: Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      );
                                    }
                                    final product =
                                        productprovider.products[index];
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 8,
                                      ),
                                      child: ProductCard(
                                        productName: product.productName,
                                        price: product.prices,
                                        stock: product.stock,
                                        onEdit: () async {
                                          final result =
                                              await Navigator.pushNamed(
                                                context,
                                                RoutesName.edit,
                                                arguments: product,
                                              );

                                          if (result == true &&
                                              context.mounted) {
                                            // Refresh with reset to reflect updated product
                                            await Provider.of<ProductProviders>(
                                              context,
                                              listen: false,
                                            ).fetchProducts(reset: true);
                                          }
                                        },
                                        onDelete:
                                            () => showCustomDeleteDialog(
                                              context,
                                              () {
                                                Provider.of<ProductProviders>(
                                                  context,
                                                  listen: false,
                                                ).deleteProduct(
                                                  product.productID,
                                                );
                                              },
                                            ),
                                      ),
                                    );
                                  } else {
                                    return const Padding(
                                      padding: EdgeInsets.all(16),
                                      child: Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    );
                                  }
                                },
                              ),
                    ),
                  ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 1,
      backgroundColor: Colors.white,
      toolbarHeight: 124,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          color: AppColor.primary,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 56,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search products',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 0,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon: const Icon(Icons.search),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Color(0x80FFAB62),
                        ),
                        child: IconButton(
                          onPressed: () {},
                          icon: SvgPicture.asset(
                            AppIcon.filter,
                            color: Colors.white,
                            height: 24,
                            width: 24,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
