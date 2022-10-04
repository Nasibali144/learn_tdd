/// TODO: Todo6 - Create class NumberTriviaRepository
import 'package:dartz/dartz.dart';
import 'package:learn_tdd/core/error/failures.dart';
import 'package:learn_tdd/features/domain/entities/number_trivia.dart';

abstract class NumberTriviaRepository {
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(int number);
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia();
}