import 'dart:convert';

import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart';
import 'package:html/parser.dart';
class API {
  static var HOST = "https://mrcong.com/page/";

  static Future<String> Get(int value) async {
    var headers = {
      'User-Agent':
          "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/107.0.0.0 Safari/537.36"
    };
    var responsitory =
        await get(Uri.parse(HOST + value.toString()), headers: headers);
    if (responsitory.statusCode == 200) {
      return responsitory.body;
    } else {
      return responsitory.reasonPhrase!;
    }
  }

  static Future<String> GetLink(value) async {
    var headers = {
      'User-Agent':
          "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/107.0.0.0 Safari/537.36"
    };
    var responsitory = await get(Uri.parse(value), headers: headers);
    if (responsitory.statusCode == 200) {
      return responsitory.body;
    } else {
      return responsitory.reasonPhrase!;
    }
  }

  static Future<String> PictureGet(page) async{
    var url = "https://wakwb.com/category/load.php?id=4988&page="+page.toString();
    print(url);
    var headers = {
      "User-Agent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/107.0.0.0 Safari/537.36",
    };
    var responsive = await get(
      Uri.parse(url),
      headers: headers
    );
    if(responsive.statusCode==200)
    {
      return responsive.body;
    }else{
      return responsive.reasonPhrase!;
    }
  }

  static Future<String> ImageGetList(page) async {

    var headers = {
      'referer': 'https://www.zcool.com.cn/collection/ZMjg1NzY4OTY=?from=search&word=%E7%BE%8E%E5%A5%B3',
      'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/107.0.0.0 Safari/537.36'
    };

    var responsive = await get(
      Uri.parse("https://m.zcool.com.cn/collection/api/ZMjg1NzY4OTY=?pageSize=30&p="+page.toString()),
      headers: headers,
    );

    if(responsive.statusCode==200)
    {
      return responsive.body;
    }else{
      return responsive.reasonPhrase!;
    }
  }
  static Future<String> ImageGetListImage(urlPage) async {

    var headers = {
      'referer': 'https://www.zcool.com.cn/collection/ZMjg1NzY4OTY=?from=search&word=%E7%BE%8E%E5%A5%B3',
      'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/107.0.0.0 Safari/537.36'
    };

    var responsive = await get(
      Uri.parse(urlPage),
      headers: headers,
    );
    if(responsive.statusCode==200)
    {
      var document = parse(responsive.body);
      var text = document.getElementById("__NEXT_DATA__")!.text.toString();
      return text;
    }else{
      return responsive.reasonPhrase!;
    }
  }
}
