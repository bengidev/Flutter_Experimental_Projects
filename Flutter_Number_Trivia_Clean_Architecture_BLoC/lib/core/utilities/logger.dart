import 'package:logger/logger.dart';

void useLogger({required Object object}) {
  final logger = _initializeLogger();
  logger.d(object);
}

Logger _initializeLogger() {
  return Logger(
    printer: PrettyPrinter(
        // number of method calls to be displayed
        methodCount: 5,
        // number of method calls if stacktrace is provided
        errorMethodCount: 10,
        // width of the output
        lineLength: 120,
        // Colorful log messages
        colors: true,
        // Print an emoji for each log message
        printEmojis: true,
        // Should each log print contain a timestamp
        printTime: false),
  );
}
