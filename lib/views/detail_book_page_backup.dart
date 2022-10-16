/* Author: hamamulfauzi
  Practitioner: Johan Hartono
  Flutter Bootcamp: edspert.id batch 7 
*/
import 'dart:convert';
import 'package:book_app/models/book_detail_response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'image_view_screen.dart';

class DetailBookPage extends StatefulWidget {
  const DetailBookPage({Key? key, required this.isbn}) : super(key: key);
  final String isbn;

  @override
  State<DetailBookPage> createState() => _DetailBookPage();
}

class _DetailBookPage extends State<DetailBookPage> {
  BookDetailResponse? detailBook;
  fetchDetailBookApi() async {
    // ignore: avoid_print
    print(widget.isbn);
    var url = Uri.parse('https://api.itbook.store/1.0/books/${widget.isbn}');
    //var url = Uri.parse('https://api.itbook.store/1.0/books/9781642002140');
    var response = await http.get(url);
    // ignore: avoid_print
    //print('Response status: ${response.statusCode}');
    // ignore: avoid_print
    //print('Response body: ${response.body}');
    // ignore: avoid_print
    //print(await http.read(Uri.https('example.com', 'foobar.txt')));

    if (response.statusCode == 200) {
      final jsonDetail = jsonDecode(response.body);
      detailBook = BookDetailResponse.fromJson(jsonDetail);
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    fetchDetailBookApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Center(child: Text('Detail'))),
        body: detailBook == null
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      GestureDetector(onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ImageViewScreen(
                                    imageUrl: detailBook!.image!)));
                        Image.network(
                          detailBook!.image!,
                          height: 100,
                        );
                      }),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(detailBook!.title!),
                              Text(detailBook!.subtitle!),
                            ]),
                      )
                    ],
                  ),
                  Text(detailBook!.price!),
                  Text(detailBook!.isbn10!),
                  Text(detailBook!.isbn13!),
                  Text(detailBook!.pages!),
                  Text(detailBook!.authors!),
                  Text(detailBook!.publisher!),
                  Text(detailBook!.rating!),
                ],
              ));
  }
}
