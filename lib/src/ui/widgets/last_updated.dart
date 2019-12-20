import 'package:flutter/material.dart';

import 'package:flutter_weather/generated/i18n.dart';


class LastUpdated extends StatelessWidget {
  final DateTime dateTime;

  LastUpdated({Key key, @required this.dateTime})
      : assert(dateTime != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
//      'Updated: ${TimeOfDay.fromDateTime(dateTime).format(context)}',
      S.of(context).updated(TimeOfDay.fromDateTime(dateTime).format(context)),
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w200,
        color: Colors.white,
      ),
    );
  }
}
