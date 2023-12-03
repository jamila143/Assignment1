import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FirstPage(),
    );
  }
}

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book List'),
      ),
      body: ListView(
        children: [
          BookCard(
            bookName: 'THE LORD OF THE RINGS',
            authorName: 'J.R.R TOLKIEN',
            rating: '4.5',
            imageUrl: 'https://cdn11.bigcommerce.com/s-gibnfyxosi/images/stencil/1920w/products/154740/156431/51eq24cRtRL__98083.1615576774.jpg?c=1',
            shortDescription: '"The Lord of the Rings" is a renowned high fantasy novel written by J.R.R. Tolkien. This epic trilogy, consisting of "The Fellowship of the Ring," "The Two Towers," and "The Return of the King," explores the perilous journey of a hobbit named Frodo Baggins as he seeks to destroy a powerful ring and save Middle-earth from the dark forces of Sauron.',
          ),
          BookCard(
            bookName: 'TO KILL A MOCKINGBIRD',
            authorName: 'HARPER LEE',
            rating: '3.8',
            imageUrl: 'https://cdn2.penguin.com.au/covers/original/9781784752637.jpg',
            shortDescription: '"To Kill a Mockingbird" is a classic novel penned by Harper Lee. Set in the American South during the 1930s, the narrative revolves around the Finch family, primarily focusing on Scout Finch, her brother Jem, and their father, Atticus Finch. The novel delves into the deep-seated racial prejudices prevalent in the Southern United States at the time. ',
          ),
        ],
      ),
    );
  }
}

class BookCard extends StatelessWidget {
  final String bookName;
  final String authorName;
  final String rating;
  final String imageUrl;
  final String shortDescription;

  BookCard({
    required this.bookName,
    required this.authorName,
    required this.rating,
    required this.imageUrl,
    required this.shortDescription,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            // Left part
            Container(
              width: 80,
              height: 120,
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 16),
            // Right part
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    bookName,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(authorName),
                  SizedBox(height: 10),
                  Text('Rating: $rating'),
                  SizedBox(height: 10),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BuyNowPage(
                            bookName: bookName,
                            authorName: authorName,
                            rating: rating,
                            imageUrl: imageUrl,
                            shortDescription: shortDescription,
                          ),
                        ),
                      );
                    },
                    icon: Icon(Icons.shopping_cart),
                    label: Text('Buy Now'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BuyNowPage extends StatelessWidget {
  final String bookName;
  final String authorName;
  final String rating;
  final String imageUrl;
  final String shortDescription;

  BuyNowPage({
    required this.bookName,
    required this.authorName,
    required this.rating,
    required this.imageUrl,
    required this.shortDescription,
  });

  final Map<String, double> bookPrices = {
    'THE LORD OF THE RINGS': 560.0,
    'TO KILL A MOCKINGBIRD': 450.0,
  };

  @override
  Widget build(BuildContext context) {
    // Set the price based on the book name
    double price = bookPrices.containsKey(bookName) ? bookPrices[bookName]! : 0.0;

    return Scaffold(
      appBar: AppBar(
        title: Text('Buy Now'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Book Name: $bookName'),
            Image.network(
              imageUrl,
              width: 80,
              height: 120,
              fit: BoxFit.cover,
            ),
            Text('Author: $authorName'),
            Text('Long Description: $shortDescription'),
            Text('Rating: $rating'),
            Text('Price: ৳${price.toStringAsFixed(2)}'),
            DropdownButton<String>(
              items: <String>['Bkash', 'Cash on Delivery', 'Nagad'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                // Handle dropdown selection
              },
              hint: Text('Select a payment option'),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}