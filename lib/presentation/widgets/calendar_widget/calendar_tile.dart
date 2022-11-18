import 'package:flutter/material.dart';
import 'package:b201_app/app/utils/calendar_utils.dart';
import 'package:b201_app/presentation/widgets/calendar_widget/clean_calendar_event.dart';
import 'package:intl/intl.dart';

/// [CalendarTile] is responsible for displaying one calendar event entry below
/// the week view or the month view. The events are displayed in a list of [CalendarTile].
///
/// Each [CalendarTile] has a set of properties:
///
/// [onDateSelected] is the callback function that gets invoked on tapping a date in the
/// calendar view. It has the type [VoidCallback]
/// [date] containes the current date to be rendered as [DateTime] type
/// [dayOfWeek] Contains the name of the weekday to be shown in the header row
/// [isDayOfWeek] is a [bool], that gets used to deiced, if the tile shoulöd display a weekday or a date
/// [isSelected] is a [bool], that contains the information, if the current tile ist the selected day
/// [inMonth] is a [bool], that contains the information, if the current day belongs to the selected month
/// [events] contains a [List<CleanCalendarEvents>] of the events to display
/// [dayOfWeekStyle] this property alloes to set a text style for the week days in the header row
/// [dateStyles] this property alloes to set a text style for the date tiles
/// [child] can contain a [Widget] that can be displayed. If tihs property is [null], the
///     method [renderDateOrDayOfWeek] gets called, so the [child] property has priority.
/// [selectedColor] is a [Color] used for displaying the selected tile
/// [todayColor] is a [Color] object used to display the tile for today
/// [eventColor] can be used to color the dots in the calendar tile representing an event. The color, that
///     is set in the properties of the [CleanCalendarEvent]  has priority over this parameter
/// [eventDoneColor] a [Color] object für displaying "done" events (events in the past)
class CalendarTile extends StatelessWidget {
  final VoidCallback? onDateSelected;
  final DateTime? date;
  final String? dayOfWeek;
  final bool isDayOfWeek;
  final bool isSelected;
  final bool inMonth;
  final List<CleanCalendarEvent>? events;
  final TextStyle? dayOfWeekStyle;
  final TextStyle? dateStyles;
  final Widget? child;
  final Color? selectedColor;
  final Color? todayColor;
  //final Color? eventColor;
  final Color? eventDoneColor;

  const CalendarTile({
    super.key,
    this.onDateSelected,
    this.date,
    this.child,
    this.dateStyles,
    this.dayOfWeek,
    this.dayOfWeekStyle,
    this.isDayOfWeek = false,
    this.isSelected = false,
    this.inMonth = true,
    this.events,
    this.selectedColor,
    this.todayColor,
    //this.eventColor,
    this.eventDoneColor,
  });

  /// This function [renderDateOrDayOfWeek] renders the week view or the month view. It is
  /// responsible for displaying a calendar tile. This can be a day (i.e. "Mon", "Tue" ...) in
  /// the header row or a date tile for each day of a week or a month. The property [isDayOfWeek]
  /// of the [CalendarTile] decides, if the rendered item should be a day or a date tile.
  Widget renderDateOrDayOfWeek(BuildContext context) {
    // We decide, if this calendar tile should display a day name in the header row. If this is the
    // case, we return a widget, that contains a text widget with style property [dayOfWeekStyle]
    if (isDayOfWeek) {
      return InkWell(
        child: Container(
          alignment: Alignment.center,
          child: Text(
            dayOfWeek ?? '',
            style: dayOfWeekStyle!.copyWith(color: Colors.grey),
          ),
        ),
      );
    } else {
      // Here the date tiles get rendered. Initially eventCount is set to 0.
      // Every date tile can show up to three dots representing an event.
      int eventCount = 0;
      return InkWell(
        onTap: onDateSelected, // react on tapping
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: Container(
            alignment: Alignment.topCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                // Date display
                Container(
                  padding: const EdgeInsets.all(2),
                  margin: const EdgeInsets.only(bottom: 2),
                  // If this tile is the selected date, draw a colored circle on it. The circle is filled with
                  // the color passed with the selectedColor parameter or red color.
                  decoration: isSelected && date != null
                      ? BoxDecoration(
                          shape: BoxShape.circle,
                          color: selectedColor != null
                              ? CalendarUtils.isSameDay(date!, DateTime.now())
                                  ? const Color.fromARGB(255, 237, 29, 36)
                                  : selectedColor
                              : Theme.of(context).primaryColor,
                        )
                      : const BoxDecoration(), // no decoration when not selected
                  child: Text(
                    date != null ? DateFormat('d').format(date!) : '',
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        color: isSelected && date != null
                            ? Colors.white
                            : CalendarUtils.isSameDay(date!, DateTime.now())
                                ? todayColor
                                : inMonth
                                    ? Colors.black
                                    : Colors
                                        .grey), // Grey color for previous or next months dates
                  ),
                ),
                // line for the events
                events != null && events!.isNotEmpty
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: events!.map((event) {
                          eventCount++;
                          // Show a maximum of 7 lines.
                          if (eventCount > 7) return Container();
                          return Container(
                              margin: const EdgeInsets.only(
                                  left: 15.0, right: 15.0, top: 1.0),
                              // width: 5.0,
                              height: 3,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  // If event is done (isDone == true) set the color of the dots to
                                  // the eventDoneColor (if given) otherwise use the primary color of
                                  // the theme
                                  // If the event is now donw yet, we use the given eventColor or the
                                  // color property of the CleanCalendarEvent. If both aren't set, then
                                  // the accent color of the theme get used.
                                  color: events![eventCount - 1].color //(() {
                                  //             if (event.isDone)
                                  //             return eventDoneColor ??
                                  //                 Theme.of(context).primaryColor;
                                  //           if (isSelected)
                                  //            Theme.of(context)
                                  //                .primaryColor; //return Colors.white;
                                  /// return eventColor ??
                                  // Theme.of(context).accentColor;
                                  // }())),
                                  ));
                        }).toList())
                    : Container(),
              ],
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // If a child widget was passed as parameter, this widget gets used to
    // be rendered to display weekday or date
    if (child != null) {
      return InkWell(
        onTap: onDateSelected,
        child: child,
      );
    }
    return Container(
      child: renderDateOrDayOfWeek(context),
    );
  }
}
