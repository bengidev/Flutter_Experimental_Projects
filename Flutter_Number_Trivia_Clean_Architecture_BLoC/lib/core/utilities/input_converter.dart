import 'package:dartz/dartz.dart';
import 'package:number_trivia_project/core/errors/failure.dart';

class InputConverter {
  Either<Failure, int> stringToUnsignedInteger({required String str}) {
    try {
      final integer = int.parse(str);
      if (integer < 0) throw const FormatException();
      return Right(integer);
    } on FormatException {
      return Left(InvalidInputFailure());
    }
  }
}
