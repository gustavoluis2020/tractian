import 'package:tractian_assets/core/failure/failure.dart';

class GetCompanyException implements Failure {
  @override
  final String message;

  @override
  final Exception? exception;

  GetCompanyException(this.message, {this.exception});
}
