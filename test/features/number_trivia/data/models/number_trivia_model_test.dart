/// TODO: todo18 - create test for NumberTriviaModel
import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:learn_tdd/features/data/models/number_trivia_model.dart';
import 'package:learn_tdd/features/domain/entities/number_trivia.dart';
import '../../../../fixtures/fixture_reader.dart';


void main() {
  const tNumberTriviaModel = NumberTriviaModel(number: 1, text: 'Test Text');

  test(
    'should be a subclass of NumberTrivia entity',
        () async {
      // assert
      expect(tNumberTriviaModel, isA<NumberTrivia>());
    },
  );

  /// TODO: todo21 add below code for do test fromJson Method
  group('fromJson', () {
    test(
      'should return a valid model when the JSON number is an integer',
          () async {
        // arrange
        final Map<String, dynamic> jsonMap =
        json.decode(fixture('trivia.json'));
        // act
        final result = NumberTriviaModel.fromJson(jsonMap);
        // assert
        expect(result, tNumberTriviaModel);
      },
    );

    test(
      'should return a valid model when the JSON number is regarded as a double',
          () async {
        // arrange
        final Map<String, dynamic> jsonMap =
        json.decode(fixture('trivia_double.json'));
        // act
        final result = NumberTriviaModel.fromJson(jsonMap);
        // assert
        expect(result, tNumberTriviaModel);
      },
    );
  });

  group('toJson', () {
    test(
      'should return a JSON map containing the proper data',
          () async {
        // act
        final result = tNumberTriviaModel.toJson();
        // assert
        final expectedJsonMap = {
          "text": "Test Text",
          "number": 1,
        };
        expect(result, expectedJsonMap);
      },
    );
  });
}