import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:route_task/src/data/product_repository/data_source/product_remote_datasource.dart';
import 'package:route_task/src/domain/usecases/get_all_product_usecase.dart';
import 'package:route_task/src/feature/product/view/widget/custom_product_item_widget.dart';
import 'package:route_task/src/feature/product/view/widget/custom_text_form_widget.dart';
import 'package:route_task/src/feature/product/view_model/products_view_model_cubit.dart';
import 'package:route_task/src/utils/app_text_style.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  ProductsViewModelCubit viewModel = ProductsViewModelCubit(
      getAllProductUseCase: injectGetAllProductUseCase());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBarWidget(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0.h),
        child: BlocBuilder<ProductsViewModelCubit, ProductsViewModelState>(
          bloc: viewModel..getProducts(),
          builder: (context, state) {
            if (state is ProductsViewModelError) {
              return Center(
                child: Text(
                  state.error ?? "",
                  style: AppTextStyle.textStyle16,
                ),
              );
            }

            if (state is ProductsViewModelSuccess) {
              return Column(
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
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 13,
                        crossAxisSpacing: 13,
                        childAspectRatio: 0.80590,
                      ),
                      itemBuilder: (context, index) {
                        return ProductItem(
                          priceOld:
                              state.productsList![index].discountPercentage,
                          descriptionImage: state.productsList![index].title,
                          pathImage: state.productsList![index].images![0],
                          onTapAddCard: () {},
                          onTapLove: () {},
                          price: state.productsList![index].price,
                          rating: state.productsList![index].rating,
                        );
                      },
                      itemCount: state.productsList!.length,
                    ),
                  )
                ],
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
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
