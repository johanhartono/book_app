/* Author: hamamulfauzi
  Practitioner: Johan Hartono
  Flutter Bootcamp: edspert.id batch 7 
*/


import 'dart:convert';
import 'package:flutter/cupertino.dart';
import '../models/book_detail_response.dart';
import '../models/book_list_response.dart';
import 'package:http/http.dart' as http;

class BookController extends ChangeNotifier {
  BookListResponse? bookList;
  fetchBookApi() async {
    var url = Uri.parse('https://api.itbook.store/1.0/new');
    var response = await http.get(
      url,
    );
/*     print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    print(await http.read(Uri.https('example.com', 'foobar.txt'))); */

    if (response.statusCode == 200) {
      final jsonBookList = jsonDecode(response.body);
      bookList = BookListResponse.fromJson(jsonBookList);
      notifyListeners();
    }
  }

  BookDetailResponse? detailBook;
  fetchDetailBookApi(isbn) async {
    // ignore: avoid_print
    //print(widget.isbn);
    var url = Uri.parse('https://api.itbook.store/1.0/books/$isbn');
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
      notifyListeners();
      fetchSimiliarBookApi(detailBook!.title!);
    }
  }

  BookListResponse? similiarBooks;
  fetchSimiliarBookApi(String title) async {
    // ignore: avoid_print
    //print(widget.isbn);
    var url = Uri.parse('https://api.itbook.store/1.0/search/$title');
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
      similiarBooks = BookListResponse.fromJson(jsonDetail);
      notifyListeners();
    }
  }
}
