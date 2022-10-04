/// TODO: todo22 - create Folder repository under data folder ana create class NumberTriviaRepositoryImpl
import 'package:dartz/dartz.dart';
import 'package:learn_tdd/core/error/exception.dart';
import 'package:learn_tdd/core/error/failures.dart';
import 'package:learn_tdd/core/network/network_info.dart';
import 'package:learn_tdd/features/data/datasources/number_trivia_local_data_source.dart';
import 'package:learn_tdd/features/data/datasources/number_trivia_remote_data_source.dart';
import 'package:learn_tdd/features/data/models/number_trivia_model.dart';
import 'package:learn_tdd/features/domain/entities/number_trivia.dart';
import 'package:learn_tdd/features/domain/repositories/number_trivia_repository.dart';

/// TODO: todo28 - add Constructor and few fields
typedef _ConcreteOrRandomChooser = Future<NumberTrivia> Function();

class NumberTriviaRepositoryImpl implements NumberTriviaRepository {
  final NumberTriviaRemoteDataSource remoteDataSource;
  final NumberTriviaLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  NumberTriviaRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(
      int number,
      ) async {
    return await _getTrivia(() {
      return remoteDataSource.getConcreteNumberTrivia(number);
    });
  }

  @override
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia() async {
    return await _getTrivia(() {
      return remoteDataSource.getRandomNumberTrivia();
    });
  }

  Future<Either<Failure, NumberTrivia>> _getTrivia(
      _ConcreteOrRandomChooser getConcreteOrRandom,
      ) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteTrivia = await getConcreteOrRandom();
        localDataSource.cacheNumberTrivia(remoteTrivia as NumberTriviaModel);
        return Right(remoteTrivia);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localTrivia = await localDataSource.getLastNumberTrivia();
        return Right(localTrivia);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}