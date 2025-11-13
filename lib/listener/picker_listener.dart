import '../model/address.dart';

/// 事件监听
abstract class CityPickerListener<T extends AddressNode> {
  /// 获取数据
  Future<List<T>> onDataLoad(int index, T? data);

  /// 选择完成
  void onFinish(List<T> data);
}
