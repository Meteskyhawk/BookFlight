class Flight {
  final String id;
  final String from;
  final String to;
  final DateTime departureTime;
  final DateTime arrivalTime;
  late final double price;
  final String airline;
  final String flightNumber;
  final String departureAirport;
  final String arrivalAirport;

  Flight({
    required this.id,
    required this.from,
    required this.to,
    required this.departureTime,
    required this.arrivalTime,
    required this.price,
    required this.airline,
    required this.flightNumber,
    required this.departureAirport,
    required this.arrivalAirport,
  });

  factory Flight.fromJson(Map<String, dynamic> json) {
    return Flight(
      id: json['icao24'],
      from: json['estDepartureAirport'],
      to: json['estArrivalAirport'],
      departureTime:
          DateTime.fromMillisecondsSinceEpoch(json['firstSeen'] * 1000),
      arrivalTime: DateTime.fromMillisecondsSinceEpoch(json['lastSeen'] * 1000),
      price: 0.0, // OpenSky API does not provide price information
      airline: json['callsign'],
      flightNumber: json['callsign'],
      departureAirport: json['estDepartureAirport'],
      arrivalAirport: json['estArrivalAirport'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'from': from,
      'to': to,
      'departureTime': departureTime,
      'arrivalTime': arrivalTime,
      'price': price,
      'airline': airline,
      'flightNumber': flightNumber,
      'departureAirport': departureAirport,
      'arrivalAirport': arrivalAirport,
    };
  }

  // Example of a data manipulation method
  void updatePrice(double newPrice) {
    if (newPrice > 0) {
      price = newPrice;
    } else {
      throw ArgumentError('Price must be positive');
    }
  }
}
