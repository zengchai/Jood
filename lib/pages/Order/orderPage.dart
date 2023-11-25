// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jood/pages/Order/reviewForm.dart';
import 'package:jood/pages/payment/payment.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}


class OrderItem {
  final String orderID;
  final String name;
  final String image;
  int quantity;
  final double price;
  final String status;

  OrderItem({
    required this.orderID,
    required this.name,
    required this.image,
    required this.quantity,
    required this.price,
    required this.status,
  });
}

class _OrderPageState extends State<OrderPage> {

  final _formKey = GlobalKey<FormState>();
  late final String review;
  late PageController _pageController;
  int _currentPageIndex = 0;

  List<OrderItem> ongoingItems = [
    OrderItem(
        orderID: '#1234',
        name: 'Fried Mee',
        image: 'assets/friedmee.jpeg',
        quantity: 2,
        price: 7.0,
        status: 'Order Preparing'),
    OrderItem(
        orderID: '#2345',
        name: 'Fried Rice',
        image: 'assets/friedrice.jpeg',
        quantity: 1,
        price: 6.0,
        status: 'Order Preparing'),
    // Add more ongoing items as needed
  ];

  List<OrderItem> historyItems = [
    OrderItem(
        orderID: '#5678',
        name: 'Fried Rice',
        image: 'assets/friedrice.jpeg',
        quantity: 1,
        price: 6.0,
        status: 'Order Delivered'),
    // Add more history items as needed
  ];

  // Date
  late DateTime currentDate = DateTime.now();
  late String formattedDate = DateFormat('dd/MM/yyyy').format(currentDate);

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPageIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _navigateToPage(int pageIndex) {
    setState(() {
      _currentPageIndex = pageIndex;
    });
    _pageController.animateToPage(
      pageIndex,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    void _popupReview(){
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Review'),
            contentPadding: EdgeInsets.all(0),
            content: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                    child: Column(
                      children: [
                        ListTile(
                          leading: Image.asset(
                            'assets/friedmee.jpeg',
                            width: 120,
                            height: 120,
                          ),
                          title: Text("Fried Mee"),
                          subtitle: Text('RM7.0'),
                        ),
                        SizedBox(height: 20), // Add some spacing between ListTile and TextField
                        reviewForm(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    };
    //Date
    DateTime currentDate = DateTime.now();
    String formattedDate = DateFormat('dd/MM/yyyy').format(currentDate);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "MY ORDER",
                  style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.calendar_today,
                      color: Colors.black,
                    ),
                    SizedBox(width: 4.0),
                    Text(
                      formattedDate,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () => _navigateToPage(0),
                  style: TextButton.styleFrom(
                    backgroundColor: _currentPageIndex == 0
                        ? Color.fromARGB(
                            255, 250, 169, 63) // Highlight the selected button
                        : null,
                  ),
                  child: Text('Ongoing'),
                ),
                TextButton(
                  onPressed: () => _navigateToPage(1),
                  style: TextButton.styleFrom(
                    backgroundColor: _currentPageIndex == 1
                        ? Color.fromARGB(
                            255, 250, 169, 63) // Highlight the selected button
                        : null,
                  ),
                  child: Text('History'),
                ),
              ],
            ),
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPageIndex = index;
                });
              },
              children: [
                _buildOrderList(ongoingItems),
                _buildOrderList(historyItems),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderList(List<OrderItem> items) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildOrderItemCard(items[index]);
      },
    );
  }

  Widget _buildOrderItemCard(OrderItem orderItem) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(15, 8, 0, 0),
            height: 32,
            width: 400,
            decoration: BoxDecoration(
              color: Color.fromRGBO(226, 193, 142, 1),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30)),
            ),
            child: Text('${orderItem.orderID}',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                )),
          ),
          Container(
            width: 400,
            decoration: BoxDecoration(
              color: Color.fromRGBO(248, 232, 209, 1),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30)),
            ),
            child: ListTile(
              contentPadding: EdgeInsets.all(8),
              leading: Image.asset(
                orderItem.image,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
              title: Text(orderItem.name),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Quantity: ${orderItem.quantity}'),
                      Text('Price: \$${orderItem.price.toStringAsFixed(2)}'),
                      Text('Status: ${orderItem.status}'),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
