import 'package:dartz/dartz.dart';
import 'package:route_task/src/data/product_repository/data_source/product_remote_datasource.dart';
import 'package:route_task/src/data/product_repository/repository/product_repository.dart';
import 'package:route_task/src/domain/entites/product_entity.dart';
import 'package:route_task/src/domain/repository/repository/product_repository.dart';
import 'package:route_task/src/helper/failures.dart';

class GetAllProductUseCase {
  final ProductRepository productRepository;

  GetAllProductUseCase({required this.productRepository});
  Future<Either<Failure, ResponseProductEntity>> invoke() async {
    return productRepository.getAllProduct();
  }
}

GetAllProductUseCase injectGetAllProductUseCase() {
  return GetAllProductUseCase(productRepository: injectProductRepository());
}
