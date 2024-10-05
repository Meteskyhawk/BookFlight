import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DepartureDatePage extends StatefulWidget {
  final DateTime? initialDepartureDate;
  final DateTime? initialReturnDate;
  final bool isRoundTrip;

  const DepartureDatePage({
    super.key,
    this.initialDepartureDate,
    this.initialReturnDate,
    required this.isRoundTrip,
  });

  @override
  _DepartureDatePageState createState() => _DepartureDatePageState();
}

class _DepartureDatePageState extends State<DepartureDatePage> {
  late DateTime _selectedDepartureDate;
  DateTime? _selectedReturnDate;
  DateTime _currentDepartureMonth = DateTime.now();
  DateTime _currentReturnMonth = DateTime.now().add(const Duration(days: 30));

  @override
  void initState() {
    super.initState();
    _selectedDepartureDate = widget.initialDepartureDate ?? DateTime.now();
    _selectedReturnDate = widget.initialReturnDate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: const Text(
          'Departure Date',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: _buildDateField('Departure', _selectedDepartureDate),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildDateField('Return', _selectedReturnDate),
                ),
              ],
            ),
          ),
          _buildWeekDaysRow(),
          Expanded(
            child: ListView(
              children: [
                _buildMonthCalendar(_currentDepartureMonth, true),
                _buildMonthCalendar(_currentReturnMonth, false),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context, {
                  'departure':
                      DateFormat('dd/MM/yyyy').format(_selectedDepartureDate),
                  'return': _selectedReturnDate != null
                      ? DateFormat('dd/MM/yyyy').format(_selectedReturnDate!)
                      : '',
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFEC441E),
                minimumSize: const Size(double.infinity, 50),
                foregroundColor:
                    Colors.white, // Set the button text color to white
              ),
              child: const Text('Select'),
            ),
          ),
          const SizedBox(
            height: 65,
          )
        ],
      ),
    );
  }

  Widget _buildDateField(String label, DateTime? date) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const Icon(Icons.calendar_today, color: Colors.grey),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: const TextStyle(color: Colors.grey)),
                const SizedBox(height: 4),
                Text(
                  date != null
                      ? DateFormat('dd/MM/yyyy').format(date)
                      : '+ Add $label Date',
                  style: const TextStyle(
                    color: Color(0xff555555),
                    fontFamily: 'CupertinoSystemText',
                    fontSize: 14.0,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.3,
                    height: 1.4,
                    decoration: TextDecoration.none,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeekDaysRow() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Mon', style: TextStyle(fontWeight: FontWeight.bold)),
          Text('Tue', style: TextStyle(fontWeight: FontWeight.bold)),
          Text('Wed', style: TextStyle(fontWeight: FontWeight.bold)),
          Text('Thu', style: TextStyle(fontWeight: FontWeight.bold)),
          Text('Fri', style: TextStyle(fontWeight: FontWeight.bold)),
          Text('Sat', style: TextStyle(fontWeight: FontWeight.bold)),
          Text('Sun', style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildMonthCalendar(DateTime month, bool isDepartureCalendar) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => _selectMonthYear(context, isDepartureCalendar),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              '${DateFormat('MMMM').format(month)} ${month.year}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            childAspectRatio: 1.5,
          ),
          itemCount: _daysInMonth(month),
          itemBuilder: (context, index) {
            final day = DateTime(month.year, month.month, index + 1);
            final isThisMonth = day.month == month.month;
            final isSelected = isDepartureCalendar
                ? isSameDay(day, _selectedDepartureDate)
                : (_selectedReturnDate != null &&
                    isSameDay(day, _selectedReturnDate!));

            return GestureDetector(
              onTap: isThisMonth
                  ? () => _onDaySelected(day, isDepartureCalendar)
                  : null,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:
                      isSelected ? const Color(0xFFEC441E) : Colors.transparent,
                ),
                child: Center(
                  child: Text(
                    '${day.day}',
                    style: TextStyle(
                      color: isThisMonth
                          ? (isSelected ? Colors.white : Colors.black)
                          : Colors.grey,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  int _daysInMonth(DateTime month) {
    final firstDayOfMonth = DateTime(month.year, month.month, 1);
    final firstDayOfNextMonth = DateTime(month.year, month.month + 1, 1);
    return firstDayOfNextMonth.difference(firstDayOfMonth).inDays;
  }

  Future<void> _selectMonthYear(
      BuildContext context, bool isDepartureCalendar) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate:
          isDepartureCalendar ? _currentDepartureMonth : _currentReturnMonth,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      initialDatePickerMode: DatePickerMode.year,
    );
    if (picked != null) {
      setState(() {
        if (isDepartureCalendar) {
          _currentDepartureMonth = DateTime(picked.year, picked.month);
        } else {
          _currentReturnMonth = DateTime(picked.year, picked.month);
        }
      });
    }
  }

  void _onDaySelected(DateTime selectedDay, bool isDepartureCalendar) {
    setState(() {
      if (isDepartureCalendar) {
        _selectedDepartureDate = selectedDay;
        if (_selectedReturnDate != null &&
            _selectedReturnDate!.isBefore(selectedDay)) {
          _selectedReturnDate = null;
        }
      } else {
        if (selectedDay.isAfter(_selectedDepartureDate)) {
          _selectedReturnDate = selectedDay;
        }
      }
    });
  }

  bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}
