import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia_project/core/utilities/network_info.dart';

import 'network_info_test.mocks.dart';

@GenerateNiceMocks([MockSpec<InternetConnectionChecker>()])
@GenerateNiceMocks([MockSpec<NetworkInfoImpl>()])
void main() {
  late MockInternetConnectionChecker mockInternetConnectionChecker;
  late NetworkInfoImpl networkInfoImpl;

  setUp(() {
    mockInternetConnectionChecker = MockInternetConnectionChecker();
    networkInfoImpl = NetworkInfoImpl(
      internetConnectionChecker: mockInternetConnectionChecker,
    );
  });

  group("isConnected", () {
    test(
      "Should forward the call to InternetConnectionChecker.hasConnection",
      () async {
        // Arrange
        final tHasConnectionFuture = Future<bool>.value(true);

        when(mockInternetConnectionChecker.hasConnection)
            .thenAnswer((realInvocation) {
          return tHasConnectionFuture;
        });
        // Act
        final result = networkInfoImpl.isConnected;
        // Assert
        verify(mockInternetConnectionChecker.hasConnection);
        expect(result, tHasConnectionFuture);
      },
    );
  });
}
