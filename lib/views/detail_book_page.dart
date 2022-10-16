/* Author: hamamulfauzi
  Practitioner: Johan Hartono
  Flutter Bootcamp: edspert.id batch 7 
*/
import 'package:book_app/controllers/book_controller.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

import 'image_view_screen.dart';

class DetailBookPage extends StatefulWidget {
  const DetailBookPage({Key? key, required this.isbn}) : super(key: key);
  final String isbn;

  @override
  State<DetailBookPage> createState() => _DetailBookPage();
}

class _DetailBookPage extends State<DetailBookPage> {
  BookController? controller;

  @override
  void initState() {
    super.initState();
    controller = Provider.of<BookController>(context, listen: false);
    controller!.fetchDetailBookApi(widget.isbn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Center(child: Text('Detail'))),
        body: Consumer<BookController>(builder: (context, controller, child) {
          return controller.detailBook == null
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ImageViewScreen(
                                          imageUrl:
                                              controller.detailBook!.image!)));
                            },
                            child: Image.network(
                              controller.detailBook!.image!,
                              height: 100,
                            ),
                          ),
                          //}),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    controller.detailBook!.title!,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    controller.detailBook!.authors!,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      //fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: List.generate(
                                      5,
                                      (index) => Icon(
                                        Icons.star,
                                        color: index <
                                                int.parse(controller
                                                    .detailBook!.rating!)
                                            ? Colors.yellow
                                            : Colors.grey,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    controller.detailBook!.subtitle!,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(
                                    controller.detailBook!.price!,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      //fontWeight: FontWeight.bold,
                                      color: Colors.green,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          //Text(detailBook!.subtitle!),
                        ],
                      ),
                      // ignore: sized_box_for_whitespace
                      const SizedBox(
                        height: 20,
                      ),
                      // ignore: sized_box_for_whitespace
                      Container(
                        width: double.infinity,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              fixedSize: const Size(double.infinity, 10),
                            ),
                            onPressed: () async {
                              Uri uri = Uri.parse(controller.detailBook!.url!);
                              try {
                                await canLaunchUrl(uri)
                                    ? launchUrl(uri)
                                    // ignore: avoid_print
                                    : print('tidak berhasil');
                                // ignore: avoid_print
                                print(uri);
                              } catch (e) {
                                // ignore: avoid_print
                                print('error');
                                // ignore: avoid_print
                                print(e);
                              }
                            },
                            child: const Text('BUY')),
                      ),
                      const SizedBox(height: 10),
                      Text(controller.detailBook!.desc!),
                      const SizedBox(height: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text("Year:${controller.detailBook!.year!}"),
                          Text("ISBN${controller.detailBook!.isbn10!}"),
                          //Text(detailBook!.isbn13!),
                          Text("${controller.detailBook!.pages!} Page"),
                          Text(
                              "Publisher: ${controller.detailBook!.publisher!}"),
                          Text(
                              "Language : ${controller.detailBook!.language!}"),

                          //Text(detailBook!.rating!),
                        ],
                      ),
                      const Divider(),
                      controller.similiarBooks == null
                          ? const CircularProgressIndicator()
                          // ignore: sized_box_for_whitespace
                          : Container(
                              height: 150,
                              child: ListView.builder(
                                  //shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount:
                                      controller.similiarBooks!.books!.length,
                                  //physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    final current = controller
                                        .similiarBooks!.books![index];
                                    // ignore: avoid_unnecessary_containers, sized_box_for_whitespace
                                    return Container(
                                        width: 100,
                                        child: Column(
                                          children: [
                                            Image.network(
                                              current.image!,
                                              height: 100,
                                            ),
                                            Text(
                                              current.title!,
                                              maxLines: 3,
                                              textAlign: TextAlign.center,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ));
                                  }),
                            )
                    ],
                  ),
                );
        }));
  }
}
