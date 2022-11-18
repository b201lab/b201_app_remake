import 'package:b201_app/app/core/themes/color_theme.dart';
import 'package:b201_app/presentation/widgets/calendar_widget/clean_calendar_event.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

var monthName = const [
  'JAN',
  'FEB',
  'MAR',
  'APR',
  'MEI',
  'JUN',
  'JUL',
  'AGS',
  'SEP',
  'OKT',
  'NOV',
  'DES'
];

class EventItem extends StatelessWidget {
  const EventItem({Key? key, required this.event}) : super(key: key);
  final CleanCalendarEvent event;

  @override
  Widget build(BuildContext context) {
    final String start = DateFormat('HH:mm').format(event.startTime).toString();
    final String startMonth = DateFormat('M').format(event.startTime);
    final String displayMonth = monthName[int.parse(startMonth) - 1];
    final String displayDate = DateFormat('d').format(event.startTime);
    final String end = DateFormat('HH:mm').format(event.endTime).toString();
    return Container(
      height: 120,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 80,
            padding:
                const EdgeInsets.only(top: 15, bottom: 15, left: 15, right: 15),
            margin:
                const EdgeInsets.only(top: 15, bottom: 15, left: 20, right: 15),
            decoration: BoxDecoration(
                color: ColorTheme.redColor,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(20, 0, 0, 0),
                    offset: Offset(3, 6),
                    blurRadius: 50,
                  ),
                ]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  displayMonth,
                  style: Theme.of(context).textTheme.headline2?.copyWith(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  displayDate,
                  style: Theme.of(context).textTheme.headline2?.copyWith(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w600),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: event.color.withOpacity(0.25),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 5, bottom: 5),
                  margin: const EdgeInsets.only(bottom: 5),
                  child: Text(
                    event.type,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2
                        ?.copyWith(color: event.color, fontSize: 8),
                  ),
                ),
                Text(
                  event.summary,
                  style: Theme.of(context).textTheme.headline2?.copyWith(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5, bottom: 5),
                  child: Text(
                    '$start- $end WIB',
                    style: Theme.of(context).textTheme.bodyText2?.copyWith(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                  ),
                ),
                Text(
                  event.description,
                  style: Theme.of(context).textTheme.caption?.copyWith(
                        color: ColorTheme.darkGrayColor,
                        fontSize: 10,
                      ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
