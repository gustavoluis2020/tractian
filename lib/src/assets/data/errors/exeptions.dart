import 'package:tractian_assets/core/failure/failure.dart';

class GetLocationException implements Failure {
  @override
  final String message;

  @override
  final Exception? exception;

  GetLocationException(this.message, {this.exception});
}

class GetAssetException implements Failure {
  @override
  final String message;

  @override
  final Exception? exception;

  GetAssetException(this.message, {this.exception});
}
