import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:newsflix/dependency_injection.dart';

void main() async {
  group('App Colors test', () {
    test(
        'Given the instance of AppColors, '
        'When primary was accessed, '
        'Then it should return the Color of hex 0xFFF7BF4F.', () async {
      // ARRANGE
      final primary = $appStyles.colors.primary;

      // ACT

      // ASSERT
      expect(const Color(0xFFF7BF4F), primary);
    });

    test(
        'Given the instance of AppColors, '
        'When secondary was accessed, '
        'Then it should return the Color of hex 0xFFFFCF00.', () async {
      // ARRANGE
      final secondary = $appStyles.colors.secondary;

      // ACT

      // ASSERT
      expect(const Color(0xFFFFCF00), secondary);
    });

    test(
        'Given the instance of AppColors, '
        'When tertiary was accessed, '
        'Then it should return the Color of hex 0xFF120E00.', () async {
      // ARRANGE
      final tertiary = $appStyles.colors.tertiary;

      // ACT

      // ASSERT
      expect(const Color(0xFF120E00), tertiary);
    });

    test(
        'Given the instance of AppColors, '
        'When accentGray was accessed, '
        'Then it should return the Color of hex 0xFFF5F5F5.', () async {
      // ARRANGE
      final accentGray = $appStyles.colors.accentGray;

      // ACT

      // ASSERT
      expect(const Color(0xFFF5F5F5), accentGray);
    });

    test(
        'Given the instance of AppColors, '
        'When customGreen was accessed, '
        'Then it should return the Color of hex 0xFF38493F.', () async {
      // ARRANGE
      final customGreen = $appStyles.colors.customGreen;

      // ACT

      // ASSERT
      expect(const Color(0xFF38493F), customGreen);
    });

    test(
        'Given the instance of AppColors, '
        'When cream was accessed, '
        'Then it should return the Color of hex 0xFFFCF8E8.', () async {
      // ARRANGE
      final cream = $appStyles.colors.cream;

      // ACT

      // ASSERT
      expect(const Color(0xFFFCF8E8), cream);
    });
  });
}
