import 'package:flutter/material.dart';

class CardItem {
  final String title;
  final String date;
  bool pinned;

  CardItem(this.title, this.date, {this.pinned = false});
}

class SeeAllWorksheetPage extends StatelessWidget {
  static const routeName = "/see_all_explore_category";
  static int page = 3;
  final List<CardItem> cardItems = [
    CardItem('Card 1', '2022-01-01'),
    CardItem('Card 2', '2022-02-01'),
    CardItem('Card 3', '2022-03-01'),
    // Add more card items as needed
  ];

  SeeAllWorksheetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Card List Page',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        backgroundColor: Colors.white, // Set the app bar background color
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Search...',
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
                // DropdownButton<String>(
                //   items: const [
                //     DropdownMenuItem(child: Text('Newest')),
                //     DropdownMenuItem(child: Text('Oldest')),
                //     DropdownMenuItem(child: Text('Most Important')),
                //     DropdownMenuItem(child: Text('Most Used')),
                //   ],
                //   onChanged: (String? value) {
                //     // Handle dropdown value change
                //   },
                // )
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cardItems.length,
              itemBuilder: (context, index) {
                final cardItem = cardItems[index];
                return Container(
                  margin: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            cardItem.title,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // Handle delete button click
                        },
                        child: const Icon(Icons.delete),
                      ),
                      TextButton(
                        onPressed: () {
                          // Handle pin button click
                        },
                        child: Icon(
                          cardItem.pinned
                              ? Icons.push_pin
                              : Icons.push_pin_outlined,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          cardItem.date,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
