// class Messagemodel {
//   final String senderId;
//   final String message;
//   final DateTime timestamp;

//   Messagemodel({
//     required this.senderId,
//     required this.message,
//     required this.timestamp,
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       'senderId': senderId,
//       'message': message,
//       'timestamp': timestamp.toIso8601String(), // Convert DateTime to a string
//     };
//   }

//   // Create a factory constructor to create an instance from a map
//   factory Messagemodel.fromMap(Map<String, dynamic> map) {
//     return Messagemodel(
//       senderId: map['senderId'],
//       message: map['message'],
//       timestamp: DateTime.parse(map['timestamp']), // Parse the string back to DateTime
//     );
//   }
// }

class Messagemodel {
  final String senderId;
  final String message;
  final DateTime timestamp;

  Messagemodel({
    required this.senderId,
    required this.message,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'message': message,
      'timestamp': timestamp.toIso8601String(), // Convert DateTime to a string
    };
  }

  // Create a factory constructor to create an instance from a map
  factory Messagemodel.fromMap(Map<String, dynamic> map) {
    return Messagemodel(
      senderId: map['senderId'],
      message: map['message'],
      timestamp: map['timestamp'] is int
          ? DateTime.fromMillisecondsSinceEpoch(map['timestamp'])
          : DateTime.parse(map['timestamp']), // Parse the string back to DateTime
    );
  }
}
