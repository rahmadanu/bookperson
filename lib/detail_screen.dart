import 'package:bookperson/model/book.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final Book book;

  const DetailScreen({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  color: const Color(0xFF7E57C2),
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                            left: 16, top: 100, right: 16, bottom: 16),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 32,
                          clipBehavior: Clip.hardEdge,
                          child: ClipRRect(
                            child: Image.network(
                              book.cover,
                              width: 140,
                              height: 200,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Text(
                              book.title,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "by ${book.author}",
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                            left: 16, top: 16, right: 16, bottom: 32),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                const Text(
                                  'Pages',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  book.pageCount.toString(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                const Text(
                                  'Published Date',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  book.publishedDate,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                          ),
                        ),
                        const BookmarkButton(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Book Description",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ShowMoreDescriptionButton(description: book.description),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BookmarkButton extends StatefulWidget {
  const BookmarkButton({super.key});

  @override
  State<StatefulWidget> createState() => _BookmarkState();
}

class _BookmarkState extends State<BookmarkButton> {
  bool isMarked = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        setState(() {
          isMarked = !isMarked;
          showSnackBar();
        });
      },
      icon: Icon(
        (isMarked) ? Icons.bookmark : Icons.bookmark_border,
        color: Colors.white,
      ),
    );
  }

  void showSnackBar() {
    final snackBar = SnackBar(
      duration: const Duration(seconds: 2),
      content: Text((isMarked) ? 'Book marked!' : 'Book unmarked!'),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          setState(() {
            isMarked = !isMarked;
          });
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

class ShowMoreDescriptionButton extends StatefulWidget {
  final String description;

  const ShowMoreDescriptionButton({super.key, required this.description});

  @override
  State<StatefulWidget> createState() => _ShowMoreDescriptionState();
}

class _ShowMoreDescriptionState extends State<ShowMoreDescriptionButton> {
  bool showMore = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          widget.description,
          textAlign: TextAlign.justify,
          overflow: TextOverflow.fade,
          maxLines: (showMore) ? null : 7,
        ),
        IconButton(
          onPressed: () {
            setState(() {
              showMore = !showMore;
            });
          },
          icon: Icon(
            (showMore) ? Icons.arrow_drop_up : Icons.arrow_drop_down,
          ),
        ),
      ],
    );
  }
}
