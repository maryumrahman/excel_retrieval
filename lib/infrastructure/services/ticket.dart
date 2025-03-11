import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/ticket_model.dart';

class TicketServices {
  static Future<int?> postTicket(Ticket _obj) async {
    Map<String, String> header = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    final uri = Uri.parse("https:feedback.com/api/Tickets");
    final obj = json.encode(_obj.toJson());
    try {
      final response = await http.post(uri, headers: header, body: obj);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final json = jsonDecode(response.body);
        Ticket tkt = Ticket.fromJson(json);
        if (tkt.id != null) {
          return tkt.id!;
        }
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }
}
