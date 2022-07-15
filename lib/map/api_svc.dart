import 'package:http/http.dart' as http;
import 'package:joso101/map/accident_locs.dart';
import 'package:joso101/utils/constants.dart';

class ApiService {
  Future<List<AccidentModel>?> getAccidents() async {
    try {
      var url = Uri.parse(ApiConstant.baseUrl + ApiConstant.getAccidentInfoPage(3));
      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<AccidentModel> _model = accidentModelFromJson(response.body);
        return _model;
      }
    } catch (e) {
      print(e.toString());
    }
    return null;
  }
}
