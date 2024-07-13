import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:route_task/src/domain/entites/product_entity.dart';
import 'package:route_task/src/domain/usecases/get_all_product_usecase.dart';

part 'products_view_model_state.dart';

class ProductsViewModelCubit extends Cubit<ProductsViewModelState> {
  ProductsViewModelCubit({required this.getAllProductUseCase})
      : super(ProductsViewModelInitial());
  GetAllProductUseCase getAllProductUseCase;
  //? function get all Product
  void getProducts() async {
    emit(ProductsViewModelLoading());
    var either = await getAllProductUseCase.invoke();
    either.fold(
      (failure) {
        emit(ProductsViewModelError(error: failure.errorMessage));
      },
      (response) {
        emit(ProductsViewModelSuccess(productsList: response.products));
      },
    );
  }
}
