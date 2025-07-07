import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:products/core/constants/app_color.dart';
import 'package:products/core/constants/imagepath.dart';

// ignore: must_be_immutable
class ProductCard extends StatelessWidget {
  final String productName;
  late String productImage;
  final double price;
  final int stock;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  ProductCard({
    required this.productName,
    required this.price,
    required this.stock,
    this.productImage =
        'https://i.ebayimg.com/images/g/EDMAAeSwShVn~f7t/s-l400.jpg',
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 132,
      decoration: BoxDecoration(
        color: AppColor.background.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColor.background,
            spreadRadius: 1,
            // blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(1),
                image: DecorationImage(
                  image: NetworkImage(productImage),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Color(0xFFEAEAEA), width: 1),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          productName,
                          style: TextStyle(
                            color: AppColor.textPrimary,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        Container(
                          width: 75,
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            // ignore: deprecated_member_use
                            color: Color(0x2EB4420D).withOpacity(0.05),
                          ),

                          child: Center(
                            child: Text(
                              'Stock: $stock',
                              style: TextStyle(
                                color: AppColor.textSecondary,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '\$${price.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: AppColor.primary,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 32,
                          width: 100,
                          child: Center(
                            child: TextButton(
                              onPressed: onDelete,
                              style: TextButton.styleFrom(
                                side: BorderSide(
                                  color: AppColor.secondary,
                                  width: 1,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                foregroundColor: AppColor.secondary,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    AppIcon.delete,
                                    height: 24,
                                    width: 24,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    'Delete',
                                    style: TextStyle(color: AppColor.secondary),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 32,
                          width: 84,
                          decoration: BoxDecoration(
                            color: AppColor.buttonBackground,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Center(
                            child: TextButton(
                              onPressed: onEdit,
                              style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                foregroundColor: AppColor.secondary,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    AppIcon.edit,
                                    height: 32,
                                    width: 32,
                                    colorFilter: ColorFilter.mode(
                                      AppColor.cardBackground,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    'Edit',
                                    style: TextStyle(
                                      color: AppColor.cardBackground,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
