import 'package:app/core/errors/failure.dart';
import 'package:app/features/auth/data/models/subModels/moneyModel.dart';
import 'package:app/features/auth/data/models/userModel.dart';
import 'package:app/features/auth/data/source/local/localDataSource.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'dart:convert';

import 'localdatasourcemockes_test.mocks.dart';

// Mock class for SharedPreferences

void main() {
  late Localdatasource localdatasource;
  late MockSharedPreferences mockSharedPreferences;
  late Usermodel testUser;

  setUp(() {
    // Initialize Mock SharedPreferences
    mockSharedPreferences = MockSharedPreferences();

    // Initialize Localdatasource with the mock
    localdatasource = Localdatasource(mockSharedPreferences);

    // Example test Usermodel object
    testUser = Usermodel(
      name: 'John Doe',
      hashedPassword: 'hashed_password',
      pin: '1234',
      email: 'john.doe@example.com',
      uid: 'uid_123',
      payDay: DateTime.parse('2023-10-18T00:00:00Z'),
      totalBalance: Moneymodel(5000, 'USD'),
      MonthlyIncome: Moneymodel(2000, 'USD'),
    );
  });

  group('Localdatasource', () {
   
    
    test('should retrieve Usermodel from SharedPreferences', () async {
      // Arrange
      final userJsonString = jsonEncode(testUser.toJson());

      when(mockSharedPreferences.containsKey('user')).thenReturn(true);
      when(mockSharedPreferences.getString('user')).thenReturn(userJsonString);

      // Act
      final result = await localdatasource.getUser();

      // Assert
      expect(result, equals(Right(testUser)));
      verify(mockSharedPreferences.getString('user'));
    });

    test('should return Failure when getting Usermodel fails', () async {
      // Arrange
      when(mockSharedPreferences.containsKey("")).thenReturn(false);

      // Act
      final result = await localdatasource.getUser();

      // Assert
      expect(result, equals(left(Failure("Error while getting User"))));
    });

    test('should return Failure when Usermodel is not found', () async {
      // Arrange
      when(mockSharedPreferences.containsKey('user')).thenReturn(false);

      // Act
      final result = await localdatasource.getUser();

      // Assert
      expect(result, equals(left(Failure("User not Found"))));
    });
  });
}

