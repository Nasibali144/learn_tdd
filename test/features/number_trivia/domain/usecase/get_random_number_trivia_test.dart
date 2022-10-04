/// TODO: todo16 - create MockNumberTriviaRepository class
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:learn_tdd/features/domain/entities/number_trivia.dart';
import 'package:learn_tdd/features/domain/repositories/number_trivia_repository.dart';
import 'package:learn_tdd/features/domain/usecases/get_random_number_trivia.dart';
import 'package:learn_tdd/features/domain/usecases/usecase.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'get_random_number_trivia_test.mocks.dart';

class MockNumberTriviaRepository extends Mock implements NumberTriviaRepository {}

@GenerateMocks([MockNumberTriviaRepository])
void main() {
  late final GetRandomNumberTrivia usecase;
  late final MockNumberTriviaRepository mockNumberTriviaRepository;

  setUp(() {
    mockNumberTriviaRepository = MockNumberTriviaRepository();
    usecase = GetRandomNumberTrivia(mockNumberTriviaRepository);
  });

  const tNumberTrivia = NumberTrivia(number: 1, text: 'test');

  test('should get trivia from the repositories', () async {
      // arrange
      when(mockNumberTriviaRepository.getRandomNumberTrivia()).thenAnswer((_) async => const Right(tNumberTrivia));
      // act
      // Since random number doesn't require any parameters, we pass in NoParams.
      final result = await usecase(NoParams());
      // assert
      expect(result, const Right(tNumberTrivia));
      verify(mockNumberTriviaRepository.getRandomNumberTrivia());
      verifyNoMoreInteractions(mockNumberTriviaRepository);
    },
  );
}