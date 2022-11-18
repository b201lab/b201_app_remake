library flutter_clean_calendar;

import 'dart:html';

import 'package:b201_app/presentation/widgets/calendar_widget/event_item.dart';
import 'package:flutter/material.dart';
import 'package:b201_app/presentation/widgets/calendar_widget/simple_gesture_detector.dart';
import 'package:b201_app/presentation/widgets/calendar_widget/calendar_tile.dart';
import 'package:b201_app/presentation/widgets/calendar_widget/clean_calendar_event.dart';
import 'package:b201_app/app/utils/calendar_utils.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:collection/collection.dart';

// Export NeatCleanCalendarEvent for using it in the application
export './clean_calendar_event.dart';

typedef DayBuilder = Function(BuildContext context, DateTime day);
typedef EventListBuilder = Function(
    BuildContext context, List<CleanCalendarEvent> events);

class Range {
  final DateTime from;
  final DateTime to;
  Range(this.from, this.to);
}

/// Clean Calndar's main class [Calendar]
///
/// This calls is responisble for controlling the look of the calnedar display as well
/// as the action taken, when changing the month or tapping a date. It's higly configurable
/// with its numerous properties.
///
/// [onDateSelected] is of type [ValueChanged<DateTime>] and it containes the callback function
///     extecuted when tapping a date
/// [onMonthChanged] is of type [ValueChanged<DateTime>] and it containes the callback function
///     extecuted when changing to another month
/// [onExpandStateChanged] is of type [ValueChanged<bool>] and it contains a callback function
///     executed when the view changes to expanded or to condensed
/// [onRangeSelected] contains a callback function of type [ValueChanged], that gets called on changes
///     of the range (switch to next or previous week or month)
/// [onEventSelected] is of type [ValueChanged<NeatCleanCalendarEvent>] and it contains a callback function
///     executed when an event of the event list is selected
/// [isExpandable] is a [bool]. With this parameter you can control, if the view can expand from week view
///     to month view. Default is [false].
/// [dayBuilder] can contain a [Widget]. If this property is not null (!= null), this widget will get used to
///     render the calenar tiles (so you can customize the view)
/// [eventListBuilder] can optionally contain a [Widget] that gets used to render the event list
/// [hideArrows] is a bool. When set to [true] the arrows to navigate to the next or previous week/month in the
///     top bar well get suppressed. Default is [false].
/// [hideTodayIcon] is a bool. When set to [true] the dispaly of the Today-Icon (button to navigate to today) in the
///     top bar well get suppressed. Default is [false].
/// [hideBottomBar] at the moment has no function. Default is [false].
/// [events] are of type [Map<DateTime, List<CleanCalendarEvent>>]. This data structure containes the events to display
/// [selctedColor] this is the color, applied to the circle on the selcted day
/// [todayColor] this is the color of the date of today
/// [todayButtonText] is a [String]. With this property you can set the caption of the today icon (button to navigate to today).
///     If left empty, the calendar will use the string "Today".
/// [eventColor] lets you optionally specify the color of the event (dot). If the [CleanCaendarEvents] property color is not set, the
///     calendar will use this parameter.
/// [eventDoneColor] with this property you can define the color of "done" events, that is events in the past.
/// [initialDate] is of type [DateTime]. It can contain an optional start date. This is the day, that gets initially selected
///     by the calendar. The default is to not set this parameter. Then the calendar uses [DateTime.now()]
/// [isExpanded] is a bool. If is us set to [true], the calendar gets rendered in month view.
/// [weekDays] contains a [List<String>] defining the names of the week days, so that it is possible to name them according
///     to your current locale.
/// [locale] is a [String]. This setting gets used to format dates according to the current locale.
/// [startOnMonday] is a [bool]. This parameter allows the calendar to determine the first day of the week.
/// [dayOfWeekStyle] is a [TextStyle] for styling the text of the weekday names in the top bar.
/// [bottomBarTextStyle] is a [TextStyle], that sets the style of the text in the bottom bar.
/// [bottomBarArrowColor] can set the [Color] of the arrow to expand/compress the calendar in the bottom bar.
/// [bottomBarColor] sets the [Color] of the bottom bar
/// [expandableDateFormat] defines the formatting of the date in the bottom bar
class Calendar extends StatefulWidget {
  final ValueChanged<DateTime>? onDateSelected;
  final ValueChanged<DateTime>? onMonthChanged;
  final ValueChanged<bool>? onExpandStateChanged;
  final ValueChanged? onRangeSelected;
  final ValueChanged<CleanCalendarEvent>? onEventSelected;
  final bool isExpandable;
  final DayBuilder? dayBuilder;
  final EventListBuilder? eventListBuilder;
  final bool hideArrows;
  final bool hideTodayIcon;
  final Map<DateTime, List<CleanCalendarEvent>>? events;
  final Color? selectedColor;
  final Color? todayColor;
  final String todayButtonText;
  final Color? eventColor;
  final Color? eventDoneColor;
  final DateTime? initialDate;
  final bool isExpanded;
  final List<String> weekDays;
  final List<String> monthName;
  final String? locale;
  final bool startOnMonday;
  final bool hideBottomBar;
  final TextStyle? dayOfWeekStyle;
  final TextStyle? dateStyles;
  final TextStyle? bottomBarTextStyle;
  final Color? bottomBarArrowColor;
  final Color? bottomBarColor;
  final String? expandableDateFormat;

  const Calendar({
    super.key,
    this.onMonthChanged,
    this.onDateSelected,
    this.onRangeSelected,
    this.onExpandStateChanged,
    this.onEventSelected,
    this.hideBottomBar = false,
    this.isExpandable = false,
    this.events,
    this.dayBuilder,
    this.eventListBuilder,
    this.hideTodayIcon = false,
    this.hideArrows = false,
    this.selectedColor,
    this.todayColor,
    this.todayButtonText = 'Today',
    this.eventColor,
    this.eventDoneColor,
    this.initialDate,
    this.isExpanded = false,
    this.weekDays = const ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'],
    this.monthName = const [
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
    ],
    this.locale = 'en_US',
    this.startOnMonday = false,
    this.dayOfWeekStyle,
    this.dateStyles,
    this.bottomBarTextStyle,
    this.bottomBarArrowColor,
    this.bottomBarColor,
    this.expandableDateFormat = 'EEEE MMM dd, yyyy',
  });

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  final calendarUtils = CalendarUtils();
  late List<DateTime> selectedMonthsDays;
  late Iterable<DateTime> selectedWeekDays;
  DateTime _selectedDate = DateTime.now();
  String? currentMonth;
  late bool isExpanded;
  String displayMonth = '';
  DateTime get selectedDate => _selectedDate;
  List<CleanCalendarEvent>? _selectedEvents;
  List<CleanCalendarEvent>? _selectedCloseEvents;

  @override
  void initState() {
    super.initState();

    isExpanded = widget.isExpanded;
    _selectedDate = widget.initialDate ?? DateTime.now();
    selectedMonthsDays = _daysInMonth(_selectedDate);
    selectedWeekDays = CalendarUtils.daysInRange(
            _firstDayOfWeek(_selectedDate), _lastDayOfWeek(_selectedDate))
        .toList();
    initializeDateFormatting(widget.locale, null).then((_) => setState(() {
          var monthFormat =
              DateFormat('M', widget.locale).format(_selectedDate);
          var yearFormat =
              DateFormat('yyyy', widget.locale).format(_selectedDate);
          displayMonth =
              '${widget.monthName[int.parse(monthFormat) - 1]} $yearFormat';
        }));
    _selectedEvents = widget.events?[DateTime(
            _selectedDate.year, _selectedDate.month, _selectedDate.day)] ??
        [];
  }

  List<CleanCalendarEvent>? getCloseEvent() {
    List<CleanCalendarEvent>? selected;
    DateTime selectedTime = DateTime.now();
    final recentSunday = DateTime(2022, 11, 1);
    final nextSunday = DateTime(2022, 11, 30);
    widget.events?.forEach((key, value) {
      if (key.compareTo(recentSunday) >= 0 && key.compareTo(nextSunday) <= 0) {
        selected?.addAll(value);
      }
    });
    print(selected);
    return selected;
  }

  Widget get nameAndIconRow {
    Widget? todayIcon;
    Widget? leftArrow;
    Widget? rightArrow;

    if (!widget.hideArrows) {
      leftArrow = IconButton(
        onPressed: isExpanded ? previousMonth : previousWeek,
        icon: const Icon(Icons.chevron_left),
      );
      rightArrow = IconButton(
        onPressed: isExpanded ? nextMonth : nextWeek,
        icon: const Icon(Icons.chevron_right),
      );
    } else {
      leftArrow = Container();
      rightArrow = Container();
    }

    if (!widget.hideTodayIcon) {
      todayIcon = InkWell(
        onTap: resetToToday,
        child: Text(widget.todayButtonText),
      );
    } else {
      todayIcon = Container();
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        leftArrow,
        Column(
          children: [
            todayIcon,
            Text(
              displayMonth,
              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w800),
            ),
          ],
        ),
        rightArrow,
      ],
    );
  }

  Widget get calendarGridView {
    return Column(children: <Widget>[
      GridView.count(
        childAspectRatio: 0.8, //ubah besar grid
        primary: false,
        shrinkWrap: true,
        crossAxisCount: 7,
        padding: const EdgeInsets.only(bottom: 0.0),
        children: calendarBuilder(),
      ),
    ]);
    /* return SimpleGestureDetector(
      onSwipeUp: _onSwipeUp,
      onSwipeDown: _onSwipeDown,
      onSwipeLeft: _onSwipeLeft,
      onSwipeRight: _onSwipeRight,
      swipeConfig: const SimpleSwipeConfig(
        verticalThreshold: 10.0,
        horizontalThreshold: 40.0,
        swipeDetectionMoment: SwipeDetectionMoment.onUpdate,
      ),
      child: Column(children: <Widget>[
        GridView.count(
          childAspectRatio: 1, //ubah besar grid
          primary: false,
          shrinkWrap: true,
          crossAxisCount: 7,
          padding: const EdgeInsets.only(bottom: 0.0),
          children: calendarBuilder(),
        ),
      ]),
    );*/
  }

  List<Widget> calendarBuilder() {
    List<Widget> dayWidgets = [];
    List<DateTime> calendarDays =
        isExpanded ? selectedMonthsDays : selectedWeekDays as List<DateTime>;
    widget.weekDays.forEach(
      (day) {
        dayWidgets.add(
          CalendarTile(
            selectedColor: widget.selectedColor,
            todayColor: widget.todayColor,
            // eventColor: widget.eventColor,
            eventDoneColor: widget.eventDoneColor,
            events: widget.events![day],
            isDayOfWeek: true,
            dayOfWeek: day,
            dateStyles:
                widget.dateStyles ?? Theme.of(context).textTheme.subtitle1,
            dayOfWeekStyle: widget.dayOfWeekStyle ??
                TextStyle(
                  color: widget.selectedColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 11,
                ),
          ),
        );
      },
    );

    bool monthStarted = false;
    bool monthEnded = false;

    calendarDays.forEach(
      (day) {
        if (day.hour > 0) {
          day = day.toLocal();
          day = day.subtract(Duration(hours: day.hour));
        }

        if (monthStarted && day.day == 01) {
          monthEnded = true;
        }

        if (CalendarUtils.isFirstDayOfMonth(day)) {
          monthStarted = true;
        }

        if (widget.dayBuilder != null) {
          // Use the dayBuilder widget passed as parameter to render the date tile
          dayWidgets.add(
            CalendarTile(
              selectedColor: widget.selectedColor,
              todayColor: widget.todayColor,
              // eventColor: widget.eventColor,
              eventDoneColor: widget.eventDoneColor,
              events: widget.events![day],
              child: widget.dayBuilder!(context, day),
              date: day,
              onDateSelected: () => handleSelectedDateAndUserCallback(day),
            ),
          );
        } else {
          dayWidgets.add(
            CalendarTile(
                selectedColor: widget.selectedColor,
                todayColor: widget.todayColor,
                // eventColor: widget.eventColor,
                eventDoneColor: widget.eventDoneColor,
                events: widget.events![day],
                onDateSelected: () => handleSelectedDateAndUserCallback(day),
                date: day,
                dateStyles: configureDateStyle(monthStarted, monthEnded),
                isSelected: CalendarUtils.isSameDay(selectedDate, day),
                inMonth: day.month == selectedDate.month),
          );
        }
      },
    );
    return dayWidgets;
  }

  TextStyle? configureDateStyle(monthStarted, monthEnded) {
    TextStyle? dateStyles;
    final TextStyle? body1Style = Theme.of(context).textTheme.bodyText2;

    if (isExpanded) {
      final TextStyle body1StyleDisabled = body1Style!.copyWith(
          color: Color.fromARGB(
        100,
        body1Style.color!.red,
        body1Style.color!.green,
        body1Style.color!.blue,
      ));

      dateStyles =
          monthStarted && !monthEnded ? body1Style : body1StyleDisabled;
    } else {
      dateStyles = body1Style;
    }
    return dateStyles;
  }

  Widget get expansionButtonRow {
    if (widget.isExpandable) {
      return GestureDetector(
        onTap: toggleExpanded,
        child: Container(
          color:
              widget.bottomBarColor ?? const Color.fromRGBO(200, 200, 200, 0.2),
          height: 40,
          margin: const EdgeInsets.only(top: 8.0),
          padding: const EdgeInsets.all(0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(width: 40.0),
              Text(
                DateFormat(widget.expandableDateFormat, widget.locale)
                    .format(_selectedDate),
                style:
                    widget.bottomBarTextStyle ?? const TextStyle(fontSize: 13),
              ),
              IconButton(
                onPressed: toggleExpanded,
                iconSize: 25.0,
                padding:
                    const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                icon: isExpanded
                    ? Icon(
                        Icons.arrow_drop_up,
                        color: widget.bottomBarArrowColor ?? Colors.black,
                      )
                    : Icon(
                        Icons.arrow_drop_down,
                        color: widget.bottomBarArrowColor ?? Colors.black,
                      ),
              ),
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget get closeEventList {
    List<CleanCalendarEvent>? selected = getCloseEvent();
    return Expanded(
      child: selected != null && selected.isNotEmpty
          ? ListView.builder(
              padding: const EdgeInsets.only(),
              itemBuilder: (BuildContext context, int index) {
                final CleanCalendarEvent event = selected[index];

                return EventItem(
                  event: event,
                );
              },
              itemCount: selected.length,
            )
          : Container(),
    );
  }

  Widget get eventList {
    if (widget.eventListBuilder == null) {
      return Expanded(
        child: _selectedEvents != null && _selectedEvents!.isNotEmpty
            ? ListView.builder(
                padding: const EdgeInsets.only(),
                itemBuilder: (BuildContext context, int index) {
                  final CleanCalendarEvent event = _selectedEvents![index];

                  return EventItem(
                    event: event,
                  ); /*SizedBox(
                    height: 60.0,
                    child: InkWell(
                      onTap: () {
                        if (widget.onEventSelected != null) {
                          widget.onEventSelected!(event);
                        }
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: ColoredBox(
                                color: event.color,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 75,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(event.summary,
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle2),
                                  Text(event.description)
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 20,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(start,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1),
                                  Text(end,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );*/
                },
                itemCount: _selectedEvents!.length,
              )
            : Container(),
      );
    } else {
      // eventLiostBuilder is not null
      return widget.eventListBuilder!(context, _selectedEvents!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          nameAndIconRow,
          ExpansionCrossFade(
            collapsed: calendarGridView,
            expanded: calendarGridView,
            isExpanded: isExpanded,
          ),
          Text(
            'Today Event',
            style: Theme.of(context).textTheme.headline2?.copyWith(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.w800),
          ),
          // expansionButtonRow, //  untuk expanse
          eventList,
          closeEventList
          //  Text(
          //    'Kegiatan Terdekat',
          //    style: Theme.of(context).textTheme.headline2?.copyWith(
          //        color: Colors.black, fontSize: 20, fontWeight: FontWeight.w800),
          //  ),
        ],
      ),
    );
  }

  /// The function [resetToToday] is called on tap on the Today button in the top
  /// position of the screen. It re-caclulates the range of dates, so that the
  /// month view or week view changes to a range containing the current day.
  ///

  void resetToToday() {
    _selectedDate = DateTime.now();
    var firstDayOfCurrentWeek = _firstDayOfWeek(_selectedDate);
    var lastDayOfCurrentWeek = _lastDayOfWeek(_selectedDate);

    setState(() {
      selectedWeekDays =
          CalendarUtils.daysInRange(firstDayOfCurrentWeek, lastDayOfCurrentWeek)
              .toList();
      selectedMonthsDays = _daysInMonth(_selectedDate);

      var monthFormat = DateFormat('M', widget.locale).format(_selectedDate);
      var yearFormat = DateFormat('yyyy', widget.locale).format(_selectedDate);
      displayMonth =
          '${widget.monthName[int.parse(monthFormat) - 1]} $yearFormat';
      _selectedEvents = widget.events?[DateTime(
              _selectedDate.year, _selectedDate.month, _selectedDate.day)] ??
          [];
    });

    _launchDateSelectionCallback(_selectedDate);
  }

  void nextMonth() {
    setState(() {
      _selectedDate = CalendarUtils.nextMonth(_selectedDate);
      var firstDateOfNewMonth = CalendarUtils.firstDayOfMonth(_selectedDate);
      var lastDateOfNewMonth = CalendarUtils.lastDayOfMonth(_selectedDate);
      updateSelectedRange(firstDateOfNewMonth, lastDateOfNewMonth);
      selectedMonthsDays = _daysInMonth(_selectedDate);
      var monthFormat = DateFormat('M', widget.locale).format(_selectedDate);
      var yearFormat = DateFormat('yyyy', widget.locale).format(_selectedDate);
      displayMonth =
          '${widget.monthName[int.parse(monthFormat) - 1]} $yearFormat';
      _selectedEvents = widget.events?[DateTime(
              _selectedDate.year, _selectedDate.month, _selectedDate.day)] ??
          [];
    });
    _launchDateSelectionCallback(_selectedDate);
  }

  void previousMonth() {
    setState(() {
      _selectedDate = CalendarUtils.previousMonth(_selectedDate);
      var firstDateOfNewMonth = CalendarUtils.firstDayOfMonth(_selectedDate);
      var lastDateOfNewMonth = CalendarUtils.lastDayOfMonth(_selectedDate);
      updateSelectedRange(firstDateOfNewMonth, lastDateOfNewMonth);
      selectedMonthsDays = _daysInMonth(_selectedDate);
      var monthFormat = DateFormat('M', widget.locale).format(_selectedDate);
      var yearFormat = DateFormat('yyyy', widget.locale).format(_selectedDate);
      displayMonth =
          '${widget.monthName[int.parse(monthFormat) - 1]} $yearFormat';
      _selectedEvents = widget.events?[DateTime(
              _selectedDate.year, _selectedDate.month, _selectedDate.day)] ??
          [];
    });
    _launchDateSelectionCallback(_selectedDate);
  }

  void nextWeek() {
    setState(() {
      _selectedDate = CalendarUtils.nextWeek(_selectedDate);
      var firstDayOfCurrentWeek = _firstDayOfWeek(_selectedDate);
      var lastDayOfCurrentWeek = _lastDayOfWeek(_selectedDate);
      updateSelectedRange(firstDayOfCurrentWeek, lastDayOfCurrentWeek);
      selectedWeekDays =
          CalendarUtils.daysInRange(firstDayOfCurrentWeek, lastDayOfCurrentWeek)
              .toList();
      var monthFormat = DateFormat('M', widget.locale).format(_selectedDate);
      var yearFormat = DateFormat('yyyy', widget.locale).format(_selectedDate);
      displayMonth =
          '${widget.monthName[int.parse(monthFormat) - 1]} $yearFormat';
      _selectedEvents = widget.events?[DateTime(
              _selectedDate.year, _selectedDate.month, _selectedDate.day)] ??
          [];
    });
    _launchDateSelectionCallback(_selectedDate);
  }

  void previousWeek() {
    setState(() {
      _selectedDate = CalendarUtils.previousWeek(_selectedDate);
      var firstDayOfCurrentWeek = _firstDayOfWeek(_selectedDate);
      var lastDayOfCurrentWeek = _lastDayOfWeek(_selectedDate);
      updateSelectedRange(firstDayOfCurrentWeek, lastDayOfCurrentWeek);
      selectedWeekDays =
          CalendarUtils.daysInRange(firstDayOfCurrentWeek, lastDayOfCurrentWeek)
              .toList();
      var monthFormat = DateFormat('M', widget.locale).format(_selectedDate);
      var yearFormat = DateFormat('yyyy', widget.locale).format(_selectedDate);
      displayMonth =
          '${widget.monthName[int.parse(monthFormat) - 1]} $yearFormat';
      _selectedEvents = widget.events?[DateTime(
              _selectedDate.year, _selectedDate.month, _selectedDate.day)] ??
          [];
    });
    _launchDateSelectionCallback(_selectedDate);
  }

  void updateSelectedRange(DateTime start, DateTime end) {
    Range rangeSelected = Range(start, end);
    if (widget.onRangeSelected != null) {
      widget.onRangeSelected!(rangeSelected);
    }
  }

  void _onSwipeUp() {
    if (isExpanded) toggleExpanded();
  }

  void _onSwipeDown() {
    if (!isExpanded) toggleExpanded();
  }

  void _onSwipeRight() {
    if (isExpanded) {
      previousMonth();
    } else {
      previousWeek();
    }
  }

  void _onSwipeLeft() {
    if (isExpanded) {
      nextMonth();
    } else {
      nextWeek();
    }
  }

  void toggleExpanded() {
    if (widget.isExpandable) {
      setState(() => isExpanded = !isExpanded);
      if (widget.onExpandStateChanged != null) {
        widget.onExpandStateChanged!(isExpanded);
      }
    }
  }

  void handleSelectedDateAndUserCallback(DateTime day) {
    var firstDayOfCurrentWeek = _firstDayOfWeek(day);
    var lastDayOfCurrentWeek = _lastDayOfWeek(day);
    // Check if the selected day falls into the next month. If this is the case,
    // then we need to additionaly check, if a day in next year was selected.
    if (_selectedDate.month > day.month) {
      // Day in next year selected? Switch to next month.
      if (_selectedDate.year < day.year) {
        nextMonth();
      } else {
        previousMonth();
      }
    }
    // Check if the selected day falls into the last month. If this is the case,
    // then we need to additionaly check, if a day in last year was selected.
    if (_selectedDate.month < day.month) {
      // Day in next last selected? Switch to next month.
      if (_selectedDate.year > day.year) {
        previousMonth();
      } else {
        nextMonth();
      }
    }
    setState(() {
      _selectedDate = day;
      selectedWeekDays =
          CalendarUtils.daysInRange(firstDayOfCurrentWeek, lastDayOfCurrentWeek)
              .toList();
      selectedMonthsDays = _daysInMonth(day);
      _selectedEvents = widget.events?[_selectedDate] ?? [];
    });
    _launchDateSelectionCallback(day);
  }

  void _launchDateSelectionCallback(DateTime day) {
    if (widget.onDateSelected != null) {
      widget.onDateSelected!(day);
    }
    if (widget.onMonthChanged != null) {
      widget.onMonthChanged!(day);
    }
  }

  _firstDayOfWeek(DateTime date) {
    var day = DateTime.utc(
        _selectedDate.year, _selectedDate.month, _selectedDate.day, 12);
    if (widget.startOnMonday == true) {
      day = day.subtract(Duration(days: day.weekday - 1));
    } else {
      // if the selected day is a Sunday, then it is already the first day of week
      day = day.weekday == 7 ? day : day.subtract(Duration(days: day.weekday));
    }
    return day;
  }

  _lastDayOfWeek(DateTime date) {
    return _firstDayOfWeek(date).add(const Duration(days: 7));
  }

  /// The function [_daysInMonth] takes the parameter [month] (which is of type [DateTime])
  /// and calculates then all the days to be displayed in month view based on it. It returns
  /// all that days in a [List<DateTime].
  List<DateTime> _daysInMonth(DateTime month) {
    var first = CalendarUtils.firstDayOfMonth(month);
    var daysBefore = first.weekday;
    var firstToDisplay = first.subtract(Duration(days: daysBefore - 1));
    var last = CalendarUtils.lastDayOfMonth(month);

    var daysAfter = 7 - last.weekday;

    // If the last day is sunday (7) the entire week must be rendered
    if (daysAfter == 0) {
      daysAfter = 7;
    }

    // Adding an extra day necessary. Otherwise the week with days in next month
    // would always end on Saturdays.
    var lastToDisplay = last.add(Duration(days: daysAfter + 1));
    return CalendarUtils.daysInRange(firstToDisplay, lastToDisplay).toList();
  }
}

///Untuk expanse
class ExpansionCrossFade extends StatelessWidget {
  final Widget collapsed;
  final Widget expanded;
  final bool isExpanded;

  const ExpansionCrossFade(
      {super.key,
      required this.collapsed,
      required this.expanded,
      required this.isExpanded});

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      firstChild: collapsed,
      secondChild: expanded,
      firstCurve: const Interval(0.0, 1.0, curve: Curves.fastOutSlowIn),
      secondCurve: const Interval(0.0, 1.0, curve: Curves.fastOutSlowIn),
      sizeCurve: Curves.decelerate,
      crossFadeState:
          isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
      duration: const Duration(milliseconds: 300),
    );
  }
}
