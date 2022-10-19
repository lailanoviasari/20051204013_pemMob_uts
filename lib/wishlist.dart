/* import 'package:flutter/material.dart';
import 'package:flutter_uts_8/main.dart';
import 'databaseHelper.dart';

class ViewWishlist extends StatefulWidget {
  const ViewWishlist({Key? key}) : super(key: key);

  @override
  State<ViewWishlist> createState() => ViewWishlist_state();
}

class ViewWishlist_state extends State<ViewWishlist> {
  List<Map<String, dynamic>> _daftar_ = [];


  final data = SQLHelper.getItems();
  
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _synopsisController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();
  final TextEditingController _castController = TextEditingController();
  final TextEditingController _genreController = TextEditingController();
  final TextEditingController _statusController = TextEditingController();

  void list(int? id) async {
      final dftr_wishlist =
          _daftar_.firstWhere((element) => element['id'] == id);
      _titleController.text = dftr_wishlist['title'];
      _synopsisController.text = dftr_wishlist['synopsis'];
      _yearController.text = dftr_wishlist['year'];
      _castController.text = dftr_wishlist['cast'];
      _genreController.text = dftr_wishlist['genre'];
      _statusController.text = dftr_wishlist['status'];
  }
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
  
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wishlist Movie and Drama'),
      ),
      body: ListView(
        padding: EdgeInsets.all(10),
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
                  hintMaxLines: 5,
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
            child: Text('Create'),
          ),
        ],
      ),
    );
    //),
    //);
  }
}
 */