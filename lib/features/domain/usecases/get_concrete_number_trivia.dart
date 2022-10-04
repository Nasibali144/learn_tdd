/// TODO: todo9 - create class GetConcreteNumberTrivia

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:learn_tdd/core/error/failures.dart';
import 'package:learn_tdd/features/domain/entities/number_trivia.dart';
import 'package:learn_tdd/features/domain/repositories/number_trivia_repository.dart';

import 'usecase.dart';

/// TODO: todo13 - create Param class, delete execute method and update below class: add extends class
class GetConcreteNumberTrivia extends UseCase<NumberTrivia, Params>{

  final NumberTriviaRepository repository;

  GetConcreteNumberTrivia(this.repository);

  /// TODO: todo11 - write code bellow
  // Future<Either<Failure, NumberTrivia>> execute({required int number}) async {
  //   return await repository.getConcreteNumberTrivia(number);
  // }

  /// TODO: todo14 - write code bellow
  @override
  Future<Either<Failure, NumberTrivia>> call(Params params) async {
    return await repository.getConcreteNumberTrivia(params.number);
  }
}

class Params extends Equatable {
  final int number;

  const Params({required this.number});

  @override
  List<Object?> get props => [];
}