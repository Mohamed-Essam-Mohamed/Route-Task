import 'package:dartz/dartz.dart';
import 'package:route_task/src/data/api/api_manget.dart';
import 'package:route_task/src/domain/entites/product_entity.dart';
import 'package:route_task/src/domain/repository/data_source/product_remote_data_source.dart';
import 'package:route_task/src/helper/failures.dart';

class ProductRemoteDataSourceImp implements ProductRemoteDataSource {
  ApiManager apiManager;

  ProductRemoteDataSourceImp({required this.apiManager});
  @override
  Future<Either<Failure, ResponseProductEntity>> getAllProduct() async {
    var either = await apiManager.getAllProduct();
    return either.fold(
      (l) => Left(
        Failure(errorMessage: l.errorMessage),
      ),
      (response) => Right(
        response,
      ),
    );
  }
}

ProductRemoteDataSource injectProductRemoteDataSource() {
  return ProductRemoteDataSourceImp(apiManager: ApiManager.instance);
}
