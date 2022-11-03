import 'package:http/http.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
class API{

  static var HOST = "https://mrcong.com/page/";


  static Future<String> Get(int value) async {
    var headers = {
      'User-Agent': "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/107.0.0.0 Safari/537.36"
    };
    var responsitory = await get( Uri.parse(HOST+value.toString()), headers: headers );
    if(responsitory.statusCode == 200){
      return responsitory.body;
    }else{
      return responsitory.reasonPhrase!;
    }
  }
  static Future<String> GetLink(value) async {
    var headers = {
      'User-Agent': "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/107.0.0.0 Safari/537.36"
    };
    var responsitory = await get( Uri.parse(value), headers: headers );
    if(responsitory.statusCode == 200){
      return responsitory.body;
    }else{
      return responsitory.reasonPhrase!;
    }
  }
}