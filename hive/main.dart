import 'package:flutter/material.dart';

class Item {
  String name;
  bool isAvailable;

  Item({
    required this.name,
    this.isAvailable = false,
  });
}

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ShoppingList(),
    );
  }
}

class ShoppingList extends StatefulWidget {
  const ShoppingList({Key? key}) : super(key: key);

  @override
  State<ShoppingList> createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  final List<Item> _items = [
    Item(name: 'apples'),
    Item(
      name: 'oranges',
    ),
  ];

  late TextEditingController _controller;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();

    _controller = TextEditingController();
    _focusNode = FocusNode();
  }

  void _addItem(String? text) {
    if (text != null && text.isNotEmpty) {
      _controller.clear();
      _focusNode.requestFocus();
      setState(() {
        _items.insert(
          0,
          Item(
            name: text,
          ),
        );
      });
    }
  }

  void _toggleItem(int index) {
    setState(() {
      _items[index].isAvailable = !_items[index].isAvailable;
    });
  }

  void _removeItem(int index) {
    setState(() {
      _items.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Shopping List'),
        elevation: 0.0,
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.separated(
                itemCount: _items.length,
                itemBuilder: (BuildContext context, int index) => ListItem(
                  title: _items[index].name,
                  isAvailable: _items[index].isAvailable,
                  onToggle: () {
                    _toggleItem(index);
                  },
                  onDelete: () {
                    _removeItem(index);
                  },
                ),
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(
                  height: 8.0,
                ),
              ),
            ),
          ),
          Container(
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _controller,
                      focusNode: _focusNode,
                      onSubmitted: (String? text) {
                        _addItem(text);
                      },
                      decoration: const InputDecoration(
                        hintText: 'Grapes',
                      ),
                    ),
                  ),
                ),
                TextButton(
                  child: const Text('Submit'),
                  onPressed: () {
                    _addItem(_controller.text);
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  final String title;
  final bool isAvailable;
  final VoidCallback? onDelete;
  final VoidCallback? onToggle;

  const ListItem({
    Key? key,
    required this.title,
    this.isAvailable = false,
    this.onDelete,
    this.onToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          title: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
            ),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: onToggle,
                icon: Icon(
                  isAvailable
                      ? Icons.check_box_rounded
                      : Icons.check_box_outline_blank_rounded,
                ),
              ),
              IconButton(
                onPressed: onDelete,
                icon: const Icon(
                  Icons.delete_forever_rounded,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
