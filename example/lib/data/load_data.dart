import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:lpinyin/lpinyin.dart';

import 'model.dart';

class DataUtils {
  static Future<List<MyData>> getDataFromNet(String keywords) async {
    var url = 'Your key or other api';
    var param = {
      "keywords": keywords,
      "subdistrict": 1,
      "key": "Your key or other api",
    };
    Response response = await Dio().request(url, queryParameters: param);
    DataModel data = DataModel.fromJson(response.data);
    List<MyData> result = [];
    if (data.info == "OK") {
      DistrictsModel model = data.districts!.first;
      for (int i = 0; i < model.districts!.length; i++) {
        String letter = PinyinHelper.getFirstWordPinyin(
          model.districts![i].name!,
        ).substring(0, 1).toUpperCase();
        result.add(
          MyData(
            name: model.districts![i].name,
            code: model.districts![i].adcode,
            letter: letter,
          ),
        );
      }
    }
    return result;
  }

  static Future<List<MyData>> getDataFromAssets(String? code) async {
    final jsonStr = await rootBundle.loadString('assets/data.json');
    final data = await json.decode(jsonStr);

    List<MyData> filteredData = [];
    Set<String> tempData = {};

    if (code == null || code.isEmpty) {
      // 取省
      for (var item in data) {
        if (item['city'] == 0 && item['area'] == 0 && item['town'] == 0) {
          if (!tempData.contains(item['province'])) {
            String letter = PinyinHelper.getPinyinE(item["name"]).substring(0, 1).toUpperCase();
            filteredData.add(MyData(letter: letter, code: item["code"], name: item["name"]));
            tempData.add(item['province']);
          }
        }
      }
    } else {
      final p = code.substring(0, 2);
      final c = code.substring(2, 4);
      final a = code.substring(4, 6);

      if (int.parse(a) > 0) {
        // 取街道
        for (var item in data) {
          if (item['province'] == p &&
              item['city'] == c &&
              item['area'] == a &&
              item['town'] != 0) {
            if (!tempData.contains(item['town'].toString())) {
              String letter = PinyinHelper.getPinyinE(item["name"]).substring(0, 1).toUpperCase();
              filteredData.add(MyData(letter: letter, code: item["code"], name: item["name"]));
              tempData.add(item['town'].toString());
            }
          }
        }
      } else if (int.parse(c) > 0 && int.parse(a) == 0) {
        // 取区
        for (var item in data) {
          if (item['province'] == p &&
              item['city'] == c &&
              item['area'] != 0 &&
              item['town'] == 0) {
            if (!tempData.contains(item['area'].toString())) {
              String letter = PinyinHelper.getPinyinE(item["name"]).substring(0, 1).toUpperCase();
              filteredData.add(MyData(letter: letter, code: item["code"], name: item["name"]));
              tempData.add(item['area'].toString());
            }
          }
        }
      } else if (int.parse(p) > 0 && int.parse(a) == 0 && int.parse(c) == 0) {
        // 取市
        for (var item in data) {
          if (item['province'] == p &&
              item['city'] != 0 &&
              item['area'] == 0 &&
              item['town'] == 0) {
            if (!tempData.contains(item['city'].toString())) {
              String letter = PinyinHelper.getPinyinE(item["name"]).substring(0, 1).toUpperCase();
              filteredData.add(MyData(letter: letter, code: item["code"], name: item["name"]));
              tempData.add(item['city'].toString());
            }
          }
        }
      }
    }

    return filteredData;
  }
}
