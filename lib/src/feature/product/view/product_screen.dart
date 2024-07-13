import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:route_task/src/feature/product/view/widget/custom_product_item_widget.dart';
import 'package:route_task/src/feature/product/view/widget/custom_text_form_widget.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _appBarWidget(),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0.h),
          child: Column(
            children: [
              //? section search
              Row(
                children: [
                  Expanded(
                    child: CustomTextFormFieldWidget(
                      controller: TextEditingController(),
                      myValidator: (text) => null,
                      keyboardType: TextInputType.text,
                    ),
                  ),
                  IconButton(
                    onPressed: null,
                    icon: SvgPicture.asset(
                      "assets/icons/icon-cart.svg",
                      height: 25.h,
                      width: 25.w,
                      fit: BoxFit.fill,
                    ),
                  ),
                ],
              ),
              Gap(20.h),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.79,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 13,
                    crossAxisSpacing: 13,
                    childAspectRatio: 0.80590,
                  ),
                  itemBuilder: (context, index) {
                    return ProductItem(
                      descriptionImage: "Nike Shoes flexible for wo..",
                      pathImage: "assets/images/test-poduct.png",
                      onTapAddCard: () {},
                      onTapLove: () {},
                      price: "200",
                    );
                  },
                ),
              )
            ],
          ),
        ));
  }

  AppBar _appBarWidget() {
    return AppBar(
      title: SvgPicture.asset(
        "assets/icons/icon-logo-route.svg",
        height: 25.h,
        width: 50.w,
      ),
    );
  }
}
