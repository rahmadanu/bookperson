import 'package:bookperson/detail_screen.dart';
import 'package:bookperson/model/book.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Book> codingBooks = codingBookList;
  List<Book> flutterBooks = flutterBookList;
  String username = '';
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEDE7F6),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                alignment: AlignmentDirectional.centerStart,
                padding: const EdgeInsets.only(left: 24.0, top: 24.0, right: 24.0, bottom: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'Hi $username,\nEnjoy exploring interesting books!',
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => Dialog(
                            backgroundColor: const Color(0xF2FFFFFF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'May I know your name?'
                                  ),
                                  const SizedBox(height: 16.0),
                                  TextField(
                                    controller: _nameController,
                                    decoration: InputDecoration(
                                      prefixIcon: const Icon(Icons.account_box),
                                      filled: true,
                                      fillColor: Colors.white,
                                      hintText: 'Your name',
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      setState(() {
                                        username = _nameController.text;
                                      });
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      'Submit',
                                      style: TextStyle(
                                          color: Colors.black
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                      ),
                      icon: const Icon(
                          Icons.account_box,
                          color: Colors.deepPurple
                      ),
                      iconSize: 32,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  onChanged: (String value) {
                    List<Book> filteredCodingBooks = codingBookList.where((element) => element.title.toLowerCase().contains(value.toLowerCase())).toList();
                    List<Book> filteredFlutterBooks = flutterBookList.where((element) => element.title.toLowerCase().contains(value.toLowerCase())).toList();

                    setState(() {
                      codingBooks = filteredCodingBooks;
                      flutterBooks = filteredFlutterBooks;
                    });
                  },
                  decoration: InputDecoration(
                    prefixIcon:  const Icon(
                        Icons.search
                    ),
                    prefixIconColor: Colors.grey,
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Search books',
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              Container(
                alignment: AlignmentDirectional.centerStart,
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Coding Books',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              (codingBooks.isNotEmpty) ? SizedBox(
                height: 150,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  itemBuilder: (context, index) {
                    final Book book = codingBooks[index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return DetailScreen(book: book);
                        }));
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.network(
                            book.cover,
                            width: 120,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: codingBooks.length,
                ),
              ) :
              const Center(
                child: Text(
                  'Empty',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16
                  ),
                ),
              ),
              Container(
                alignment: AlignmentDirectional.centerStart,
                child: const Padding(
                  padding: EdgeInsets.only(left: 16.0, top: 24.0, right: 16.0, bottom: 16.0),
                  child: Text(
                    'Flutter Books',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              (flutterBooks.isNotEmpty) ? ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
                itemBuilder: (context, index) {
                  final Book book = flutterBooks[index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return DetailScreen(book: book);
                      }));
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.network(
                                  book.cover,
                                  width: 70,
                                  height: 80,
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              flex: 3,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      book.title,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(book.author),
                                    const SizedBox(height: 6),
                                    Text('Pages: ${book.pageCount}'),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                itemCount: flutterBooks.length,
              ) :
              const Center(
                child: Text(
                  'Empty',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
}