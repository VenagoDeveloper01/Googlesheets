import 'package:googlesheets/Form.dart';
import 'package:gsheets/gsheets.dart';

class SheetsFlutter{
  static String _sheetId = "1pvRUKegmPWCZyQAF6G-FyYBet835_SezNMS4Ggd8nEc";
  static const _sheetCredentials = r'''
  {
  "type": "service_account",
  "project_id": "flutter-tutorial-353410",
  "private_key_id": "ca2c9517d6dfd512e3ac8730505e4ef8c4c81488",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCQRuCcoErZVVMi\nTMx1Hn6SBDNY2YsYDaBJookf8srZsmkQcVhvxINXZ9Ez9tz3KbMQBEjVXLeCBrgw\na5S4HGUZMf/eul+mM35aAfauCdWptVtVyFrt5dECQMF0RETpIcsYgoBqs1uh+kAo\nFZf8LjPBUC++p6VcEEzcXEdTXZkJ/F4F4OEUHfliz6nN/7e2FmVfIWBSAM+ilkaL\n7jjneZUuH9PBPsz9ZmahrNSMlVtZQA/ELvP4+ABeqHlreRVskYz1w/C1vo3aeWXY\ni+tLNUb/CyNRGBrcEFibzNaTn2kQwikTqmC8eb9hY3/pvzUz339MxdVZrbO4EaWy\nxigsS6u/AgMBAAECggEAA9EMLLiEzQkCdlF9GyAKYxx0q0YIoENEA+P70qTelDGx\nsSX+cT52kapaZhCCueXC1IqjI+8cSkvuisFdzB0G2PVx+lddzmIQVps0sQKWQgiy\neNYgVFNpsFs8LYeHdySrYGObYrc0llgDYyFnGtxcsXbIkeI8xURdHtCGG9YfBUeQ\nnLnVhaJb9qdEzvF+ZYrEswv8hZGeMlRKKvmYKXMKUU6u2dVTaeD6GKff4+JD+zsW\nkTJMIbItsHKJPBgtZ2o7gB4SiorG6yIWF5f8pksZX5q4H41bnLzrIHYEqvbd479B\nWPeGEFTBrT+bT/kIHzq0Gl6FN3/HgTqYV+XWjUAS+QKBgQDGsxhQS8odSrs1Lz5L\ne+fuuWnOB3yUHh8RsK5AVMQ+RiDrdQ0qMsfZUpwXdSrKvBrcTmodFRxJ3dLafDFV\nEwffXmtPz4NjKHwEFRp43hzHeVOxBoMo8swt1BKWR2mKFAh5So2V5KxUxbpsJ/Uw\nUxhDsnkapuFr9DE1sElV3pBzdQKBgQC54gzMhGtyaf/DfZXDMi7rhqfVyjmly0XD\nm72DqoBpaUzNJlENRrKjUNd2fpw/xLV/nNJHEP9kA649046bDQ1oIzKhf2j5F+0n\noZE1QH00dFPpdxrzRnZX9WIs25yReLFBf0AUWhGJneH+HMw4UzG/dLN3T8PpgVCT\n3lUVLq2/4wKBgF3pgeFZoOJtUsQVWy0UGA/VpHNTSIc9IVQcHI+dQM9qF98RiLJc\nI+bMS6guoZYGh+9+RFsQgjlLVYAcWLir8Pmax7+GBcRU+yB21Pcxi4qgBnVR7aXp\n86TpaguLHw+63jJtkTO6S9UZSz4ZOKKpc3tznBeDrmF2ndeRRWgHdGCNAoGBAJ95\nYoWsLgqxCi8L9YrL6RlEI4X1w1OMe8QAP61QgG7vWma/MtZzCxu2ZcRRh3fmKdjc\nEEPMP2/tAHYmpLg9kH0BhZSsnMDoWByiLtRDCagRDVTFTKfekfWQnrPhjgf4Rgrt\nQ2qyg01P2O2Mg2Dnb0zUsIvyMSCKQzk5jEFqFMMFAoGAa9bPwaOUHPBn4PqcP+Lu\ntfVg+D7BotQXSS4s7R1MN6qmU/NwLBqebLwRWy8V/BXkavIwc8Yu2WfL5AC1X8tM\nm9njza9R1DFjhUgH5fc7nPcyTmSy2cN0QzlcWIuWSFG+lST89Apo9uUELdRvAbbe\nQBu6KomF81tDN5bCFuHYUzE=\n-----END PRIVATE KEY-----\n",
  "client_email": "flutter-tutorial@flutter-tutorial-353410.iam.gserviceaccount.com",
  "client_id": "115597616472680747055",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/flutter-tutorial%40flutter-tutorial-353410.iam.gserviceaccount.com"
}

''';
  static Worksheet? _userSheet;
  static final _gsheets = GSheets(_sheetCredentials);

  static Future init() async {
    try{
      final spreadsheet = await _gsheets.spreadsheet(_sheetId);

      _userSheet = await _getWorkSheet(spreadsheet, title: "RoomData");
      final firstRow = SheetsColumn.getColumns();
      _userSheet!.values.insertRow(1, firstRow);
    } catch(e) {
      print(e);
    }
  }

  static Future<Worksheet> _getWorkSheet(
      Spreadsheet spreadsheet, {
        required String title,
      }) async {
    try{
      return await spreadsheet.addWorksheet(title);
    } catch(e) {
      return spreadsheet.worksheetByTitle(title)!;
    }
  }

  static Future insert(List<Map<String, dynamic>> rowList) async {
    _userSheet!.values.map.appendRows(rowList);
  }
}