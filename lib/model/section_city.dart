import '../view/listview_section.dart';
import 'address.dart';

/// 城市列表数据模型
class SectionCity<T extends AddressNode> implements ExpandableListSection<T> {
  /// 字母
  String? letter;

  /// 当前字母的列表
  List<T>? data;

  SectionCity({
    this.letter,
    this.data,
  });

  @override
  List<T>? getItems() {
    return data;
  }

  @override
  bool isSectionExpanded() {
    return true;
  }

  @override
  void setSectionExpanded(bool expanded) {}
}
