

import 'package:download/download.dart';
import 'dart:convert' show utf8;
import 'package:path_provider/path_provider.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'dart:io';

Future newCSVFile(List<CattleRecord>? csvDoc) async {
  // Add your function code here!
  csvDoc ??= [];

  // Define the CSV header
  String fileContent =
      "TagNumber,Gender,Date of Birth,Breed,Color,Stage,Status,Weight,Source,Mother Tag Number,Father Tag Number,Cattle Value";

  // Iterate through each record and append the data to fileContent
  for (var record in csvDoc) {
    fileContent +=
        "\n${record.tagNumber},${record.gender},${record.dateOfBirth},${record.breed},${record.color},${record.stage},${record.status},${record.weight},${record.source},${record.motherTagNumber},${record.fatherTagNumber},${record.cattleValue}";
  }

  // Generate a file name with a timestamp
  final fileName = "Cattle_List_${DateTime.now().millisecondsSinceEpoch}.csv";

  // Get the local directory
  final directory = await getApplicationDocumentsDirectory();
  final path = '${directory.path}/$fileName';

  // Write the CSV content to the file
  final file = File(path);
  await file.writeAsString(fileContent);

  // Save and open the file using flutter_file_dialog
  await FlutterFileDialog.saveFile(
    params: SaveFileDialogParams(
      sourceFilePath: path,
    ),
  );
}