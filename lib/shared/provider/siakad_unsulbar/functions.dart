import 'package:skedul/shared/provider/siakad_unsulbar/siakad_model.dart';
import 'package:html/parser.dart' as html_parser;

int identifyDay(String day) {
  String match = day.toLowerCase().trim();

  switch (match) {
    case "selasa":
      return 2;
    case "rabu":
      return 3;
    case "kamis":
      return 4;
    case "jumat":
      return 5;
    case "sabtu":
      return 6;
    case "minggu":
      return 7;
    default:
      return 1;
  }
}

List<MakulResponse> parseMakul(dynamic data) {
  var document = html_parser.parse(data);
  List<MakulResponse> makulList = [];
  try {
    var table = document.getElementById('datatabel');
    var rows = table!.getElementsByTagName('tr');
    for (var row in rows) {
      var cells = row.getElementsByTagName('td');
      if (cells.isNotEmpty) {
        String namaMk = cells[1].text.split("(")[0];
        int sks = double.parse(cells[1].text.split("(")[1].replaceAll(")", ""))
            .toInt();
        int hari = identifyDay(cells[3].text.split(",")[0]);
        String kelas = cells[2].text.trim();
        String ruangan = cells[4].text.trim();
        String jam = cells[3].text.split(",")[1].trim().substring(0, 5);

        var makul = MakulResponse(hari, namaMk, ruangan, sks, jam, kelas);
        makulList.add(makul);
      }
    }
  } catch (e) {
    rethrow;
  }
  return makulList;
}
