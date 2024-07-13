import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'products_view_model_state.dart';

class ProductsViewModelCubit extends Cubit<ProductsViewModelState> {
  ProductsViewModelCubit() : super(ProductsViewModelInitial());

  
}
