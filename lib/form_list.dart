import 'package:flutter/material.dart';
import 'package:flutter_uts_8/main.dart';
import 'databaseHelper.dart';

class FormWishlist extends StatefulWidget {
  const FormWishlist({Key? key}) : super(key: key);

  @override
  State<FormWishlist> createState() => _FormWishlistState();
}

class _FormWishlistState extends State<FormWishlist> {
  List<Map<String, dynamic>> _daftar_ = [];

  void _refreshWishlist() async {
    final data = await SQLHelper.getItems();
    setState(() {
      _daftar_ = data;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshWishlist(); // Loading the wishlist when the app starts
  }

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _synopsisController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();
  final TextEditingController _castController = TextEditingController();
  final TextEditingController _genreController = TextEditingController();
  final TextEditingController _statusController = TextEditingController();

  void list(int? id) async {
      final dftrWishlist =
          _daftar_.firstWhere((element) => element['id'] == id);
      _titleController.text = dftrWishlist['title'];
      _synopsisController.text = dftrWishlist['synopsis'];
      _yearController.text = dftrWishlist['year'];
      _castController.text = dftrWishlist['cast'];
      _genreController.text = dftrWishlist['genre'];
      _statusController.text = dftrWishlist['status'];
  }

  // Insert a new wishlist to the database
  Future<void> _addItem() async {
    int year = int.parse(_yearController.text);
    await SQLHelper.createItem(
      _titleController.text,
      _synopsisController.text,
      year,
      _castController.text,
      _genreController.text,
      _statusController.text,
    );
    _refreshWishlist();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wishlist Movie and Drama'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _titleController,
              decoration: InputDecoration(
                  labelText: 'Title',
                  hintText: 'Title of the movie or drama',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _synopsisController,
              decoration: InputDecoration(
                  labelText: 'Synopsis',
                  hintText: 'Short description of the movie or drama',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  )),
                  maxLines: 5,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _yearController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: 'Year',
                  hintText: 'Year of release of the movie or drama',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _castController,
              decoration: InputDecoration(
                  labelText: 'Cast',
                  hintText: 'Actor in the movie or drama',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _genreController,
              decoration: InputDecoration(
                  labelText: 'Genre',
                  hintText: 'Type of the movie or drama',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _statusController,
              decoration: InputDecoration(
                  labelText: 'Status',
                  hintText: 'watched or unwatched',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  )),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              
              await _addItem();

              // Clear the text fields
              _titleController.text = '';
              _synopsisController.text = '';
              _yearController.text = '';
              _castController.text = '';
              _genreController.text = '';
              _statusController.text = '';

              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const MyApp()));
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
    //),
    //);
  }
}
