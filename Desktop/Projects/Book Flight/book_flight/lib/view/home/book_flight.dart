import 'package:book_flight/view/home/search_results_v2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../core/constants/app/enums.dart';
import '../../core/services/auth_service.dart';
import '../../core/services/flight_service.dart';
import 'departure_date.dart';
import 'package:provider/provider.dart';
import '../../core/base/state/flight_state.dart';

class BookFlightPage extends StatefulWidget {
  const BookFlightPage({super.key});

  @override
  _BookFlightPageState createState() => _BookFlightPageState();
}

class _BookFlightPageState extends State<BookFlightPage> {
  final TextEditingController _fromController = TextEditingController();
  final TextEditingController _toController = TextEditingController();
  final TextEditingController _departureDateController =
      TextEditingController();
  final TextEditingController _returnDateController = TextEditingController();

  bool _isLoading = false; // Initialize _isLoading
  FlightType _flightType = FlightType.oneWay;
  // ignore: unused_field
  final FlightService _flightService = FlightService();
  List<String> _airportSuggestions = [];
  String _selectedField = '';

  @override
  void initState() {
    super.initState();
    _fromController.addListener(() {
      if (_selectedField == 'From') {
        _fetchAirportSuggestions(_fromController.text);
      }
    });
    _toController.addListener(() {
      if (_selectedField == 'To') {
        _fetchAirportSuggestions(_toController.text);
      }
    });
  }

  Future<void> _fetchAirportSuggestions(String query) async {
    print("Fetching suggestions for: $query"); // Add this line
    if (query.length < 2) {
      setState(() {
        _airportSuggestions = [];
      });
      return;
    }

    final authService = AuthService();
    final accessToken = await authService.getAccessToken();

    try {
      final suggestions =
          await authService.fetchAirportSuggestions(query, accessToken);
      print("Received suggestions: $suggestions"); // Add this line
      setState(() {
        _airportSuggestions = suggestions;
      });
    } catch (error) {
      print("Error fetching suggestions: $error"); // Add this line
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                'Error fetching airport suggestions: ${error.toString()}')),
      );
    }
  }

  Widget _buildTextField(
      String label, TextEditingController controller, IconData icon) {
    return GestureDetector(
      onTap: () {
        print("Tapped on: $label"); // Add this line
        setState(() {
          _selectedField = label;
        });
        _fetchAirportSuggestions(controller.text);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: controller,
            decoration: InputDecoration(
              labelText: label,
              prefixIcon: Icon(icon, color: const Color(0xFFEC441E)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onChanged: (value) {
              if (_selectedField == label) {
                _fetchAirportSuggestions(value);
              }
            },
          ),
          Visibility(
            visible: _selectedField == label && _airportSuggestions.isNotEmpty,
            child: SizedBox(
              height: 200,
              child: ListView.builder(
                itemCount: _airportSuggestions.length,
                itemBuilder: (context, index) {
                  print(
                      "Building suggestion: ${_airportSuggestions[index]}"); // Add this line
                  return ListTile(
                    title: Text(_airportSuggestions[index]),
                    onTap: () {
                      setState(() {
                        controller.text = _airportSuggestions[index];
                        _airportSuggestions = [];
                        _selectedField = '';
                      });
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xFFF3F4F6), // Set background color to light grey
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Make AppBar transparent
        elevation: 0, // Remove elevation
        leading: const BackButton(color: Colors.black),
        title: const Text(
          'Book Flight',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(16.0),
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildTabItem('One way', FlightType.oneWay),
                _buildTabItem('Round', FlightType.roundTrip),
                _buildTabItem('Multicity', FlightType.multiCity),
              ],
            ),
          ),
          Expanded(
            child: _buildFlightForm(_flightType),
          ),
        ],
      ),
    );
  }

  Widget _buildTabItem(String title, FlightType type) {
    final bool isSelected = _flightType == type;
    return GestureDetector(
      onTap: () {
        setState(() {
          _flightType = type;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFEC441E) : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildFlightForm(FlightType flightType) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Grouped Input Fields and Search Button
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white, // Change background color to white
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              children: [
                // From TextField
                _buildTextField('From', _fromController, Icons.flight_takeoff),
                const SizedBox(height: 16),

                // To TextField
                _buildTextField('To', _toController, Icons.flight_land),
                const SizedBox(height: 16),

                // Date Fields (Departure and Return)
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate:
                                DateTime.now(), // Only allow future dates
                            lastDate: DateTime(2100),
                          );

                          if (pickedDate != null) {
                            String formattedDate =
                                DateFormat('dd/MM/yyyy').format(pickedDate);
                            setState(() {
                              _departureDateController.text = formattedDate;
                            });
                            print('Selected Date: $formattedDate'); // Debugging
                          }
                        },
                        child: _buildDateField(
                          _departureDateController.text.isEmpty
                              ? 'Select Departure'
                              : _departureDateController.text,
                          _departureDateController,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    if (flightType == FlightType.roundTrip)
                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate:
                                  DateTime.now(), // Only allow future dates
                              lastDate: DateTime(2100),
                            );

                            if (pickedDate != null) {
                              String formattedDate =
                                  DateFormat('dd/MM/yyyy').format(pickedDate);
                              setState(() {
                                _returnDateController.text = formattedDate;
                              });
                              print('Return Date: $formattedDate'); // Debugging
                            }
                          },
                          child: _buildDateField(
                            _returnDateController.text.isEmpty
                                ? '+ Add Return Date'
                                : _returnDateController.text,
                            _returnDateController,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 30),

                // Search Button with _isLoading handling
                ElevatedButton(
                  onPressed: () async {
                    final from = _fromController.text.trim();
                    final to = _toController.text.trim();
                    final date = _departureDateController.text.trim();

                    // Debugging: Log the values to see which field is empty
                    print('From: $from');
                    print('To: $to');
                    print('Date: $date');

                    if (from.isEmpty || to.isEmpty || date.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please fill all fields')),
                      );
                      return;
                    }

                    try {
                      setState(() {
                        _isLoading = true; // Start loading state
                      });

                      print('Calling fetchFlightDetails...');
                      await Provider.of<FlightState>(context, listen: false)
                          .fetchFlightDetails(from, to, date);
                      print('fetchFlightDetails completed.');

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SearchResultsPageV2(
                            flights:
                                Provider.of<FlightState>(context, listen: false)
                                    .flights,
                          ),
                        ),
                      );
                    } catch (error) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error: ${error.toString()}')),
                      );
                    } finally {
                      setState(() {
                        _isLoading = false; // Stop loading state
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 56),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    backgroundColor: const Color(0xFFEC441E),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        )
                      : const Text(
                          'Search',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                ),
                Consumer<FlightState>(
                  builder: (context, flightState, child) {
                    if (flightState.isLoading) {
                      return const CircularProgressIndicator();
                    } else if (flightState.errorMessage != null) {
                      return Text(
                        flightState.errorMessage!,
                        style: const TextStyle(color: Colors.red),
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<Map<String, String>?> _navigateToDepartureDate(
      BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DepartureDatePage(
          initialDepartureDate: _departureDateController.text.isNotEmpty
              ? DateFormat('dd/MM/yyyy').parse(_departureDateController.text)
              : null,
          initialReturnDate: _returnDateController.text.isNotEmpty
              ? DateFormat('dd/MM/yyyy').parse(_returnDateController.text)
              : null,
          isRoundTrip: _flightType == FlightType.roundTrip,
        ),
      ),
    );
    if (result != null) {
      return result as Map<String, String>;
    }
    return null;
  }

  // Helper Methods for Widgets
  Widget _buildDateField(String value, TextEditingController controller) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white, // Change background color to white
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.calendar_today, color: Color(0xFFEC441E)),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
