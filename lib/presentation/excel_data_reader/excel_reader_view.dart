import 'dart:io';

import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../../infrastructure/model/ticket_model.dart';


class ExcelReaderPage extends StatefulWidget {
  const ExcelReaderPage({super.key});

  @override
  _ExcelReaderPageState createState() => _ExcelReaderPageState();
}

class _ExcelReaderPageState extends State<ExcelReaderPage> {
  List<List<String>> _excelData = [];

  Future<void> _pickAndReadExcelFile() async {
    try {
      // Open file picker
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['xlsx'],
      );

      if (result != null) {
        File file = File(result.files.single.path!);

        // Read the Excel file
        var bytes = file.readAsBytesSync();
        var excel = Excel.decodeBytes(bytes);

        List<List<String>> data = [];

        // Iterate over the rows and columns in the first sheet
        for (var table in excel.tables.keys) {
          for (var row in excel.tables[table]!.rows) {
            // Filter out null cells and convert them to strings
            List<String> filteredRow =
                row
                    .where((cell) => cell != null) // Skip null cells
                    .map(
                      (cell) => cell!.value.toString(),
                    ) // Convert non-null cells to strings
                    .toList();

            if (filteredRow.isNotEmpty) {
              data.add(filteredRow); // Add non-empty rows
            }
          }
          break; // Read only the first sheet
        }

        setState(() {
          _excelData = data;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error reading file: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Excel File Reader')),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: _pickAndReadExcelFile,
            child: const Text('Choose Excel File'),
          ),
          Expanded(
            child:
                _excelData.isEmpty
                    ? Center(child: Text('No data loaded'))
                    : ListView.builder(
                      padding: EdgeInsets.all(8),
                      itemCount: _excelData.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(12),
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: _excelData[index].length,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, i) {
                                Ticket(
                                  entryDt: DateTime.parse(_excelData[index][0]),
                                  title: _excelData[index][1],
                                  description: "Description :"
                                );
                                return Text(_excelData[index][i]);
                              },
                            ),
                          ),
                        );
                      },
                    ),
          ),
        ],
      ),
    );
  }
}
