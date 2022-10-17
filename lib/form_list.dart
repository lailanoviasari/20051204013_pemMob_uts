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


  final TextEditingController _IDController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _synopsisController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();
  final TextEditingController _castController = TextEditingController();
  final TextEditingController _genreController = TextEditingController();
  final TextEditingController _statusController = TextEditingController();

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

  void _showForm(int? id) async {
    if (id != null) {
      final dftr_wishlist =
          _daftar_.firstWhere((element) => element['ID'] == id);
      _IDController.text = dftr_wishlist['ID'];
      _titleController.text = dftr_wishlist['title'];
      _synopsisController.text = dftr_wishlist['synopsis'];
      _yearController.text = dftr_wishlist['year'];
      _castController.text = dftr_wishlist['cast'];
      _genreController.text = dftr_wishlist['genre'];
      _statusController.text = dftr_wishlist['status'];
    }
  }

  // Insert a new wishlist to the database
  Future<void> _addItem() async {
    await SQLHelper.createItem(
      _IDController.hashCode,
      _titleController.text,
      _synopsisController.text,
      _yearController.hashCode,
      _castController.text,
      _genreController.text,
      _statusController.text,
    );
    _refreshWishlist();
  }

  // Update an existing wishlist
  Future<void> _updateItem(int id) async {
    await SQLHelper.updateItem(
      id,
      _titleController.text,
      _synopsisController.text,
      _yearController.hashCode,
      _castController.text,
      _genreController.text,
      _statusController.text,
    );
    _refreshWishlist();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text('Wishlist Movie and Drama'),
      ),
      body: ListView(
        padding: EdgeInsets.all(10),
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _IDController,
              decoration: InputDecoration(
                  labelText: 'ID',
                  hintText: 'Must entry the ID of movie or drama',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  )),
            ),
          ),
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
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _yearController,
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

                if (_IDController.text == null) {
                  await _addItem();
                }

                if (_IDController.text != null) {
                  await _updateItem(_IDController.hashCode);
                }

                for (int i = 0; i < _daftar_.length; i++) {

                  for (int j = 0; j < 8; j++) {
                    
                  }
                }

                // Clear the text fields
                _titleController.text = '';
                _synopsisController.text = '';
                _yearController.text = '';
                _castController.text = '';
                _genreController.text = '';
                _statusController.text = '';

Navigator.push(context, MaterialPageRoute(builder: (context) => const MyApp()));
              },
              child: Text('Create'),
            ),
        ],
      ),
    ));
    //),
    //);
  }
}
