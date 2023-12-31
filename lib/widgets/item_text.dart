// ignore_for_file: dead_code

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//Just shows the text inside a ListItem.
// Show due date and due time if they exist.
//### MISSING FEATURES ###
//Code needs to be refactored.
// Treat text overflow.

class ItemText extends StatelessWidget {
  final bool check;
  final String text;
  final DateTime dueDate;
  final TimeOfDay dueTime;

  const ItemText(
    this.check,
    this.text,
    this.dueDate,
    this.dueTime, {super.key}
    );

  Widget _buildText(BuildContext context) {
    if (check) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            text,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                fontSize: 22,
                color: Colors.grey,
                decoration: TextDecoration.lineThrough),
          ),
          _buildDateTimeTexts(context),
        ],
      );
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          text,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 22,
          ),
        ),
        _buildDateTimeTexts(context),
      ],
    );
  }

  Widget _buildDateText(BuildContext context) {
    return Text(
      DateFormat.yMMMd().format(dueDate).toString(),
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: 14,
        color: check ? Colors.grey : Theme.of(context).primaryColorDark,
      ),
    );
  }

  Widget _buildTimeText(BuildContext context) {
    return Text(
      dueTime.format(context),
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: 14,
        color: check ? Colors.grey : Theme.of(context).primaryColorDark,
      ),
    );
  }

  Widget _buildDateTimeTexts(BuildContext context) {
    // ignore: unnecessary_null_comparison
    if (dueTime == null) {
      return _buildDateText(context);
    } else {
      return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        _buildDateText(context),
        const SizedBox(
          width: 10,
        ),
        _buildTimeText(context),
      ],
    );
    }
  
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return _buildText(context);
  }
}
