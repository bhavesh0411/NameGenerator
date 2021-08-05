
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Name Generator",
      home: RandomWords(),
    );
  }
}

class RandomWords extends StatefulWidget {

  @override
  _RandomWordsState createState() => _RandomWordsState();
}


class _RandomWordsState extends State<RandomWords> {
  
  final _suggestiions = <WordPair>[];
  final _saved = Set<WordPair>();
  final _biggesFont = TextStyle(fontSize: 16.0);

  Widget _buildSuggestions() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i){
        if (i.isOdd) return Divider();
        final index = i ~/ 2;
        if (index >= _suggestiions.length){
          _suggestiions.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_suggestiions[index]);
      },
    );
  }

//Creating list for word pair and adding fav icon
  Widget _buildRow(WordPair pair) {
    final alreadySaved = _saved.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggesFont,
      ),
    trailing: Icon(
      alreadySaved ? Icons.favorite : Icons.favorite_border,
      color: alreadySaved ? Colors.deepPurple : null),
      onTap: (){
        setState(() {
          setState(() {
            if (alreadySaved){
              _saved.remove(pair);
            } else {
              _saved.add(pair);
            }
          });
        });
      },
    );
  }

// appBar icon push content
  void _pushsaved() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        final tiles = _saved.map(
          (pair) {
            return ListTile(
              title: Text(
                pair.asPascalCase,
                style: _biggesFont,
              ),
            );
          } 
        );
        final divided = ListTile.divideTiles(
          context: context,
          tiles: tiles,
        ).toList();
        
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.deepPurple,
            title: Text('Saved Suggestions'),
          ),
          body: ListView(children: divided,),
        );
      }),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text('Name Generator'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.list), onPressed: _pushsaved,)
        ],
        ),
      body: _buildSuggestions(),
    );
  }
}