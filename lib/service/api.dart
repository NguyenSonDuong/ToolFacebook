import 'dart:convert';

import 'package:http/http.dart';

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

  static Future<String> FacebookGetComment(id_post) async {
    var DataBody = {
      "UFI2CommentsProvider_commentsKey": "CometGroupDiscussionRootSuccessQuery",
      "__false": false,
      "__true": true,
      "after":"AQHRZnOGpO0Ps7GeuNkJHTnKpQ5GlFBRq_aud0lVBOz8LJeneFP4m08G9TKK9Nb51am80Hnmbl0kxhiONCA0rnIhNw",
      "before": null,
      "displayCommentsContextEnableComment": null,
      "displayCommentsContextIsAdPreview": null,
      "displayCommentsContextIsAggregatedShare": null,
      "displayCommentsContextIsStorySet": null,
      "displayCommentsFeedbackContext": null,
      "feedLocation": "GROUP",
      "feedbackSource": 0,
      "first": 8,
      "focusCommentID": null,
      "includeHighlightedComments": false,
      "includeNestedComments": true,
      "initialViewOption": "TOPLEVEL",
      "isInitialFetch": false,
      "isPaginating": true,
      "last": null,
      "scale": 1.5,
      "topLevelViewOption": null,
      "useDefaultActor": false,
      "viewOption": null,
      "id": base64.encode(utf8.encode("feedback:"+id_post))
    };
    var headers = {
      "Cookie":"sb=tP1sY4M-mP5FcHUF6Wxx0BZS; datr=vP1sY1aGLcEmdz0HsGZBKoSi; locale=vi_VN; c_user=100025221310339; xs=43%3ACdwYc6lh4IRk_A%3A2%3A1668087315%3A-1%3A6370; fr=0HYefOwxYn8QakdDv.AWVzc0mmk9JOuoTXUa_lC-26lSU.BjbP20.j-.AAA.0.0.BjbP4V.AWWGkbxamUQ; presence=C%7B%22t3%22%3A%5B%5D%2C%22utc3%22%3A1668087327414%2C%22v%22%3A1%7D; wd=645x860",
      "sec-ch-ua":'"Google Chrome";v="107", "Chromium";v="107", "Not=A?Brand";v="24"',
      "sec-ch-ua-mobile":"?0",
      "sec-ch-ua-platform":'"Windows"',
      "sec-fetch-site":"same-origin",
      "User-Agent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/107.0.0.0 Safari/537.36",
      "x-fb-friendly-name":"CometUFICommentsProviderForDisplayCommentsQuery",
      "Content-Type": "application/x-www-form-urlencoded",
    };


    var variables = jsonEncode(DataBody);

    var Body = {
      "av":"100025221310339",
      "__user":"100025221310339",
      "__a":"1",
      "dpr":"1.5",
      "fb_dtsg":"NAcPqvniloMRwGbnWZ3T-jIAWiv-U-ftNDqd5kfT40Px5dHlAfVwWAg:47:1656419137",
      "fb_api_caller_class":"RelayModern",
      "fb_api_req_friendly_name":"CometUFICommentsProviderForDisplayCommentsQuery",
      "variables":variables,
      "server_timestamps":"true",
      "doc_id":"5659850867392108"
    };

    var responsive = await post(
      Uri.parse("https://www.facebook.com/api/graphql/"),
      headers: headers,
      encoding: Encoding.getByName('utf-8'),
      body: Body,
    );
    if(responsive.statusCode==200)
    {
      return responsive.body;
    }else{
      return responsive.reasonPhrase!;
    }
  }


}
