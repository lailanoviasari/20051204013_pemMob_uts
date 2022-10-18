import 'package:flutter/material.dart';
import 'databaseHelper.dart';
import 'form_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        // Remove the debug banner
        debugShowCheckedModeBanner: false,
        title: 'Wishlist Movie and Drama',
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        home: const HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // All wishlist
  List<Map<String, dynamic>> _daftar_ = [];

  bool _isLoading = true;
  // This function is used to fetch all data from the database
  void _refreshWishlist() async {
    final data = await SQLHelper.getItems();
    setState(() {
      _daftar_ = data;
      _isLoading = false;
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

  // This function will be triggered when the floating button is pressed
  // It will also be triggered when you want to update an item
  void _showForm(int? id) async {
    if (id != null) {
      // id == null -> create new item
      // id != null -> update an existing item
      final existingJournal =
          _daftar_.firstWhere((element) => element['id'] == id);
      _titleController.text = existingJournal['title'];
      _synopsisController.text = existingJournal['synopsis'];
      _yearController.text = existingJournal['year'];
      _castController.text = existingJournal['cast'];
      _genreController.text = existingJournal['genre'];
      _statusController.text = existingJournal['status'];
    }

    showModalBottomSheet(
        context: context,
        elevation: 5,
        isScrollControlled: true,
        builder: (_) =>  Container(
              padding: EdgeInsets.fromLTRB(10, 30, 10, 10),
              child:   ListView(
                /* mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end, */
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
                      if (id != null) {
                        await _updateItem(id);
                      }

                      // Clear the text fields
                      _titleController.text = '';
                      _synopsisController.text = '';
                      _yearController.text = '';
                      _castController.text = '';
                      _genreController.text = '';
                      _statusController.text = '';

                      // Close the bottom sheet
                      Navigator.of(context).pop();
                    },
                    child: Text(id == null ? 'Create New' : 'Update'),
                  )
                ],
              ),
            ));
  }

  // Insert a new wishlist to the database
  /* Future<void> _addItem() async {
    await SQLHelper.createItem(
      _titleController.text,
      _synopsisController.text,
      _yearController.hashCode,
      _castController.text,
      _genreController.text,
      _statusController.text,
    );
    _refreshWishlist();
  } */

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
    return Scaffold(
        appBar: AppBar(
          title: const Text('Wishlist Movie and Drama'),
        ),
        body: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: _daftar_.length,
                itemBuilder: (context, index) => Card(
                  color: Colors.orange[200],
                  margin: const EdgeInsets.all(15),
                  child: ListTile(
                      title: Text(_daftar_[index]['title']),
                      subtitle: Text(_daftar_[index]['synopsis']),
                      trailing: SizedBox(
                        width: 100,
                        child: Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () => _showForm(_daftar_[index]['id']),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () =>
                                  _deleteItem(_daftar_[index]['id']),
                            ),
                          ],
                        ),
                      )),
                ),
              ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return FormWishlist();
            }));
          },
        ));
  }

  // Delete an item
  void _deleteItem(int id) async {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text('Anda yakin ingin menghapus wishlist?'),
            actions: <Widget>[
              TextButton(
                  onPressed: () async {
                    await SQLHelper.deleteItem(id);
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Successfully deleted a wishlist!'),
                    ));
                    Navigator.pop(context);
                    _refreshWishlist();
                  },
                  child: Text('Ya')),
              TextButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Deleting is cancelled!')));
                  Navigator.pop(context);
                },
                child: Text('Tidak'),
              )
            ],
          );
        });
  }
}
