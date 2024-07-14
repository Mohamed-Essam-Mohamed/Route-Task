import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:http/http.dart' as http;
import 'package:route_task/src/constant/api_constant.dart';
import 'dart:convert';

import 'package:route_task/src/data/api/api_manget.dart';
import 'package:route_task/src/data/model/response/product_responst_dto.dart';
import 'package:route_task/src/helper/failures.dart';

class MockConnectivity extends Mock implements Connectivity {}

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late ApiManager apiManager;
  late MockConnectivity mockConnectivity;
  late MockHttpClient mockHttpClient;

  setUp(() {
    apiManager = ApiManager.instance;
    mockConnectivity = MockConnectivity();
    mockHttpClient = MockHttpClient();
  });

  group('getAllProduct', () {
    test('should return Right with ResponseProductDto on successful API call',
        () async {
      // Arrange
      final expectedResponse = ResponseProductDto();
      final response = http.Response(jsonEncode(expectedResponse), 200);
      final url = Uri.https(apiBaseUrl, apiGetProducts);

      when(mockConnectivity.checkConnectivity())
          .thenAnswer((_) async => [ConnectivityResult.wifi]);
      when(mockHttpClient.get(url)).thenAnswer((_) async => response);

      // Act
      final result = await apiManager.getAllProduct();

      // Assert
      expect(result, equals(Right(expectedResponse)));
      verify(mockConnectivity.checkConnectivity());
      verify(mockHttpClient.get(url));
    });

    test('should return Left with ServerFailure when API call fails', () async {
      // Arrange
      final response = http.Response('Error message', 500);
      final url = Uri.https(apiBaseUrl, apiGetProducts);

      when(mockConnectivity.checkConnectivity())
          .thenAnswer((_) async => [ConnectivityResult.wifi]);
      when(mockHttpClient.get(url)).thenAnswer((_) async => response);

      // Act
      final result = await apiManager.getAllProduct();

      // Assert
      expect(
        result,
        equals(
          Left(ServerFailure(
              errorMessage: 'Error in response data please try again')),
        ),
      );
      verify(mockConnectivity.checkConnectivity());
      verify(mockHttpClient.get(url));
    });

    test(
        'should return Left with ServerFailure when there is no internet connection',
        () async {
      // Arrange
      when(mockConnectivity.checkConnectivity()).thenAnswer((_) async => []);

      // Act
      final result = await apiManager.getAllProduct();

      // Assert
      expect(
        result,
        equals(
          Left(ServerFailure(
              errorMessage: 'No Internet Connection please try again')),
        ),
      );
      verify(mockConnectivity.checkConnectivity());
      verifyZeroInteractions(mockHttpClient);
    });
  });
}
