import 'package:path_provider/path_provider.dart';
import 'dart:io';

exportData(String data) async {
  var directory = await getApplicationDocumentsDirectory();
  print(directory.path);
  var file = File('${directory.path}/data.json');
  file.writeAsString(data);
}
