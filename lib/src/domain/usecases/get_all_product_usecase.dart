import 'package:dartz/dartz.dart';
import 'package:route_task/src/domain/entites/product_entity.dart';
import 'package:route_task/src/domain/repository/repository/product_repository.dart';
import 'package:route_task/src/helper/failures.dart';

class GetAllProductUsecase {
  final ProductRepository productRepository;

  GetAllProductUsecase({required this.productRepository});
  Future<Either<Failure, ResponseProductEntity>> call() async {
    return productRepository.getAllProduct();
  }
}
