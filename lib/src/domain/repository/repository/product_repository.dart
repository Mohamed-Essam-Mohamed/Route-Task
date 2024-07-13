import 'package:dartz/dartz.dart';
import 'package:route_task/src/domain/entites/product_entity.dart';
import 'package:route_task/src/helper/failures.dart';

abstract class ProductRepository {
  Future<Either<Failure, ResponseProductEntity>> getAllProduct();
}
