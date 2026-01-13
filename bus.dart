import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

// DATA_MODEL
class BookingData extends ChangeNotifier {
  String _fromLocation;
  String _toLocation;
  int _passengerCount;
  String _type;
  DateTime _departureDate;
  int _selectedBottomNavBarIndex;

  BookingData({
    String fromLocation = 'Location 1',
    String toLocation = 'Location 2',
    int passengerCount = 1,
    String type = 'Bus',
    DateTime? departureDate,
    int selectedBottomNavBarIndex = 0,
  }) : _fromLocation = fromLocation,
       _toLocation = toLocation,
       _passengerCount = passengerCount,
       _type = type,
       _departureDate =
           departureDate ?? DateTime(2021, 6, 3), // Use a default date
       _selectedBottomNavBarIndex = selectedBottomNavBarIndex;

  String get fromLocation => _fromLocation;
  String get toLocation => _toLocation;
  int get passengerCount => _passengerCount;
  String get type => _type;
  DateTime get departureDate => _departureDate;
  int get selectedBottomNavBarIndex => _selectedBottomNavBarIndex;

  void setFromLocation(String newLocation) {
    _fromLocation = newLocation;
    notifyListeners();
  }

  void setToLocation(String newLocation) {
    _toLocation = newLocation;
    notifyListeners();
  }

  void swapLocations() {
    final String temp = _fromLocation;
    _fromLocation = _toLocation;
    _toLocation = temp;
    notifyListeners();
  }

  void incrementPassenger() {
    _passengerCount++;
    notifyListeners();
  }

  void decrementPassenger() {
    if (_passengerCount > 1) {
      _passengerCount--;
      notifyListeners();
    }
  }

  void setType(String newType) {
    _type = newType;
    notifyListeners();
  }

  void setDepartureDate(DateTime newDate) {
    _departureDate = newDate;
    notifyListeners();
  }

  void setSelectedBottomNavBarIndex(int index) {
    _selectedBottomNavBarIndex = index;
    notifyListeners();
  }
}

void main() => runApp(const BusBookingApp());

class BusBookingApp extends StatelessWidget {
  const BusBookingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bus Booking',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.deepPurple,
          accentColor: const Color(0xFF673AB7), // A purple shade from image
        ),
        fontFamily: 'Montserrat', // Example font, can be customized
      ),
      home: ChangeNotifierProvider<BookingData>(
        create: (BuildContext context) => BookingData(),
        builder: (BuildContext context, Widget? child) =>
            const BusBookingHomePage(),
      ),
    );
  }
}

class BusBookingHomePage extends StatelessWidget {
  const BusBookingHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final BookingData bookingData = Provider.of<BookingData>(context);

    // Define custom colors based on the image
    const Color primaryPurple = Color(
      0xFF6A1B9A,
    ); // A darker purple for the header background
    const Color lightPurple = Color(
      0xFF9C27B0,
    ); // Lighter purple for gradient/buttons
    const Color cardBackground = Colors.white;
    const Color accentGreen = Color(0xFF4CAF50);
    const Color accentPurple = Color(
      0xFF7E57C2,
    ); // A lighter purple for icons/text

    return Scaffold(
      backgroundColor: const Color(0xFFEDE7F6), // Light background behind cards
      body: Stack(
        //fit: StackFit.expand,
        children: <Widget>[
          // Header at the back
          SizedBox(
            height: 220,
            child: _buildHeader(context, primaryPurple, lightPurple),
          ),
          Container(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 220),
                    _buildLocationCard(
                      context,
                      cardBackground,
                      accentGreen,
                      const Color.fromARGB(255, 174, 194, 87),
                      bookingData,
                    ),
                    const SizedBox(height: 16.0),
                    _buildLocationCard(
                      context,
                      cardBackground,
                      accentGreen,
                      accentPurple,
                      bookingData,
                    ),
                    const SizedBox(height: 16.0),
                    _buildLocationCard(
                      context,
                      cardBackground,
                      accentGreen,
                      accentPurple,
                      bookingData,
                    ),
                    const SizedBox(height: 16.0),
                    _buildDetailsCard(
                      context,
                      cardBackground,
                      accentGreen,
                      accentPurple,
                      bookingData,
                    ),
                    const SizedBox(height: 24.0),
                    _buildSearchButton(context, lightPurple),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNavBar(context, bookingData),
    );
  }

  Widget _buildHeader(
    BuildContext context,
    Color primaryColor,
    Color secondaryColor,
  ) {
    return Container(
      padding: const EdgeInsets.only(
        top: 48.0,
        left: 24.0,
        right: 24.0,
        bottom: 24.0,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[primaryColor, secondaryColor],
        ),
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(30.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Icon(Icons.more_horiz, color: Colors.white, size: 30.0),
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 24.0,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24.0),
          Text(
            'Hi Jhon',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: Colors.white.withOpacity(0.8),
            ),
          ),
          Text(
            'Bus',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 36.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationCard(
    BuildContext context,
    Color cardBg,
    Color accentGreen,
    Color accentPurple,
    BookingData bookingData,
  ) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      color: cardBg,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            _buildLocationRow(
              context,
              'FROM',
              Icons.send,
              accentGreen,
              bookingData.fromLocation,
            ),
            const SizedBox(height: 16.0),
            _buildLocationRow(
              context,
              'TO',
              Icons.location_on,
              accentPurple,
              bookingData.toLocation,
              trailingWidget: _buildSwapButton(
                context,
                accentPurple,
                bookingData,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationRow(
    BuildContext context,
    String label,
    IconData icon,
    Color iconColor,
    String locationText, {
    Widget? trailingWidget,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Icon(icon, color: iconColor, size: 24.0),
        const SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                label,
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
              ),
              Text(
                locationText,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
            ],
          ),
        ),
        if (trailingWidget != null) trailingWidget,
      ],
    );
  }

  Widget _buildSwapButton(
    BuildContext context,
    Color accentPurple,
    BookingData bookingData,
  ) {
    return InkWell(
      onTap: bookingData.swapLocations,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: accentPurple.withOpacity(0.2),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Icon(Icons.swap_vert, color: accentPurple, size: 24.0),
      ),
    );
  }

  Widget _buildDetailsCard(
    BuildContext context,
    Color cardBg,
    Color accentGreen,
    Color accentPurple,
    BookingData bookingData,
  ) {
    final String formattedDate = DateFormat(
      'EEE d MMM yyyy',
    ).format(bookingData.departureDate);

    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      color: cardBg,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'PASSENGER',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Container(
                            width: 10.0,
                            height: 10.0,
                            decoration: BoxDecoration(
                              color: accentGreen,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          Text(
                            '${bookingData.passengerCount.toString().padLeft(2, '0')}',
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[800],
                                ),
                          ),
                          const SizedBox(width: 8.0),
                          Container(
                            width: 10.0,
                            height: 10.0,
                            decoration: BoxDecoration(
                              color: accentGreen.withOpacity(0.5),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'TYPE',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                      Text(
                        bookingData.type,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[800],
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24.0),
            Row(
              children: <Widget>[
                Container(
                  width: 10.0,
                  height: 10.0,
                  decoration: BoxDecoration(
                    color: accentPurple,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'DEPART',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Simulate date change for demonstration
                          bookingData.setDepartureDate(
                            DateTime.now().add(const Duration(days: 7)),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Departure date updated to: ${DateFormat('EEE d MMM yyyy').format(bookingData.departureDate)}',
                              ),
                            ),
                          );
                        },
                        child: Text(
                          formattedDate,
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[800],
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchButton(BuildContext context, Color buttonColor) {
    return SizedBox(
      width: double.infinity,
      height: 56.0,
      child: ElevatedButton(
        onPressed: () {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Searching for buses!')));
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          elevation: 4.0,
        ),
        child: Text(
          'SEARCH',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavBar(BuildContext context, BookingData bookingData) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10.0,
            spreadRadius: 2.0,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20.0)),
        child: BottomNavigationBar(
          currentIndex: bookingData.selectedBottomNavBarIndex,
          onTap: bookingData.setSelectedBottomNavBarIndex,
          selectedItemColor: Theme.of(context).colorScheme.primary,
          unselectedItemColor: Colors.grey[500],
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                bookingData.selectedBottomNavBarIndex == 0
                    ? Icons.home
                    : Icons.home_outlined,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                bookingData.selectedBottomNavBarIndex == 1
                    ? Icons.explore
                    : Icons.explore_outlined,
              ),
              label: 'Explore',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                bookingData.selectedBottomNavBarIndex == 2
                    ? Icons.access_time_filled
                    : Icons.access_time,
              ),
              label: 'History',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                bookingData.selectedBottomNavBarIndex == 3
                    ? Icons.person
                    : Icons.person_outline,
              ),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
