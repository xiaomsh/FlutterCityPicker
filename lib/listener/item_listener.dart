import 'package:flutter_city_picker/model/address.dart';

/// 城市列表事件监听
abstract class ItemClickListener<T extends AddressNode> {
  /// 点击事件
  /// tabIndex：当前 tab 索引
  /// name：城市名称
  /// code：城市代码
  void onItemClick(int tabIndex, T data);
}
