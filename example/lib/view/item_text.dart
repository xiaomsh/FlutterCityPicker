import 'package:flutter/material.dart';

class ItemTextWidget extends StatefulWidget {
  final String? title;
  final Widget? subWidget;

  const ItemTextWidget({super.key, this.title, this.subWidget});

  @override
  ItemTextWidgetState createState() => ItemTextWidgetState();
}

class ItemTextWidgetState extends State<ItemTextWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Container(
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    width: 1, color: Theme.of(context).dividerColor))),
        child: Row(
          children: <Widget>[
            Text("${widget.title}"),
            Expanded(
                child: Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: widget.subWidget))
          ],
        ),
      ),
    );
  }
}
