import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BookingPage extends StatefulWidget {
  final Map<String, dynamic> barber;

  const BookingPage({required this.barber}) : assert(barber != null, 'Barber data cannot be null');

  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  List<String> selectedServices = [];
  String? phoneNumber; // Added for payment method
  final double downPaymentAmount = 100; // Fixed down payment amount

  void _pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (date != null) setState(() => selectedDate = date);
  }

  void _pickTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time != null) setState(() => selectedTime = time);
  }

  void _confirmBooking() {
    if (selectedDate == null || selectedTime == null || selectedServices.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please complete all selections")),
      );
      return;
    }

    // Show payment method dialog
    _showPaymentMethodDialog();
  }

  void _showPaymentMethodDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Enter Payment Method"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Please enter your phone number for the down payment of ₱$downPaymentAmount"),
            TextField(
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(labelText: "Phone Number"),
              onChanged: (value) {
                phoneNumber = value; // Store the phone number
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            child: Text("Cancel"),
            onPressed: () => Navigator.of(context).pop(),
          ),
          TextButton(
            child: Text("Confirm Payment"),
            onPressed: () {
              if (phoneNumber == null || phoneNumber!.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Please enter a valid phone number")),
                );
              } else {
                Navigator.of(context).pop(); // Close the payment dialog
                _showSuccessDialog(); // Show success dialog
              }
            },
          ),
        ],
      ),
    );
  }

  void _showSuccessDialog() {
    // Show a success pop-up
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Booking Successful"),
        content: Text("Your booking with ${widget.barber['name']} has been confirmed!\n"
            "You will receive a confirmation SMS on $phoneNumber."),
        actions: [
          TextButton(
            child: Text("OK"),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Book with ${widget.barber['name']}")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Select Date & Time", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Row(
              children: [
                ElevatedButton(onPressed: _pickDate, child: Text("Pick Date")),
                SizedBox(width: 10),
                ElevatedButton(onPressed: _pickTime, child: Text("Pick Time")),
              ],
            ),
            Text(selectedDate != null ? "Date: ${DateFormat('dd MMM yyyy').format(selectedDate!)}" : ""),
            Text(selectedTime != null ? "Time: ${selectedTime!.format(context)}" : ""),
            SizedBox(height: 20),

            Text("Select Services", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Column(
              children: widget.barber['services'].map<Widget>((service) {
                return CheckboxListTile(
                  title: Text("${service['name']} - ₱${service['price']}"),
                  value: selectedServices.contains(service['name']),
                  onChanged: (bool? selected) {
                    setState(() {
                      if (selected == true) {
                        selectedServices.add(service['name']);
                      } else {
                        selectedServices.remove(service['name']);
                      }
                    });
                  },
                );
              }).toList(),
            ),

            SizedBox(height: 20),
            ElevatedButton(onPressed: _confirmBooking, child: Text("Confirm Booking")),
          ],
        ),
      ),
    );
  }
}
