/// TODO: todo33 - create number trivia bloc with extension
import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_tdd/core/error/failures.dart';
import 'package:learn_tdd/core/util/input_converter.dart';
import 'package:learn_tdd/features/domain/entities/number_trivia.dart';
import 'package:learn_tdd/features/domain/usecases/get_concrete_number_trivia.dart';
import 'package:learn_tdd/features/domain/usecases/get_random_number_trivia.dart';
import 'package:learn_tdd/features/domain/usecases/usecase.dart';

part 'number_trivia_event.dart';
part 'number_trivia_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_INPUT_FAILURE_MESSAGE = 'Invalid Input - The number must be a positive integer or zero.';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  /// TODO: todo36 - update bloc
  final GetConcreteNumberTrivia getConcreteNumberTrivia;
  final GetRandomNumberTrivia getRandomNumberTrivia;
  final InputConverter inputConverter;

  NumberTriviaBloc({
    required GetConcreteNumberTrivia concrete,
    required GetRandomNumberTrivia random,
    required this.inputConverter,
  })  : getConcreteNumberTrivia = concrete,
        getRandomNumberTrivia = random,
        super(Empty()) {

    on<GetTriviaForConcreteNumber>((event, emit) {
      final inputEither = inputConverter.stringToUnsignedInteger(event.numberString);
      inputEither.fold(
            (failure) {
          emit(const Error(message: INVALID_INPUT_FAILURE_MESSAGE));
        },
            (integer) async {
          emit(Loading());
          final failureOrTrivia = await getConcreteNumberTrivia(
            Params(number: integer),
          );
          failureOrTrivia.fold(
                (failure) => emit(Error(message: _mapFailureToMessage(failure))),
                (trivia) => emit(Loaded(trivia: trivia)),
          );
        },
      );
    });

    on<GetTriviaForRandomNumber>((event, emit) async{
      emit(Loading());
      final failureOrTrivia = await getRandomNumberTrivia(
        NoParams(),
      );
      failureOrTrivia.fold(
            (failure) => emit(Error(message: _mapFailureToMessage(failure))),
            (trivia) => emit(Loaded(trivia: trivia)),
      );
    });
  }

  String _mapFailureToMessage(Failure failure) {
    // Instead of a regular 'if (failure is ServerFailure)...'
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error';
    }
  }
}
