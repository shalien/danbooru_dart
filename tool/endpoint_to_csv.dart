import 'dart:io';

void main() {
  File endpointsFile = File('tool/_endpoint');

  List<String> endpoints = endpointsFile.readAsLinesSync();

  File csvFile = File('tool/_endpoint.csv');

  /// Split  on space , remove empty space koin with ;
  List<String> csvLines = endpoints
      .map((e) => e.split(' ').where((element) => element.isNotEmpty).join(';'))
      .toList();

  csvFile.writeAsStringSync(csvLines.join(Platform.lineTerminator));

  exit(0);
}
