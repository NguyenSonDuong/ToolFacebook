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
      "Cookie":"sb=Vu-6Yjf8FnbimmmWf--26XO_; datr=V--6YhOQivQz0M-yFX_uVFxk; c_user=100025221310339; dpr=1.125; wd=1707x793; m_page_voice=100025221310339; xs=47%3Ap885xVkAHARDVg%3A2%3A1656419137%3A-1%3A6370%3A%3AAcVpzHsZhAqIu0fgF7hwX5eO4n2eSlolcQI163a9Uhdt; fr=00FQylCSwh5j5xIaM.AWVK4ykXpcN_LSAFinO7TL_es3w.BjZ8Wm.cM.AAA.0.0.BjZ80P.AWWsLAf5r-4; presence=C%7B%22lm3%22%3A%22u.100013390414468%22%2C%22t3%22%3A%5B%5D%2C%22utc3%22%3A1667747095466%2C%22v%22%3A1%7D",
      "sec-ch-ua":'"Google Chrome";v="107", "Chromium";v="107", "Not=A?Brand";v="24"',
      "sec-ch-ua-mobile":"?0",
      "sec-ch-ua-platform":'"Windows"',
      "sec-fetch-site":"same-origin",
      "User-Agent":"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/107.0.0.0 Safari/537.36",
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
