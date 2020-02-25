import 'package:commons/src/functions/functions.dart';
import 'package:commons/src/functions/navigation_functions.dart';
import 'package:flutter/material.dart';

class ListViewScreen<T> extends StatefulWidget {
  final String title;
  final List<T> items;
  final Widget Function(T, int, String) bindViewItem;
  final bool Function(T, String) searchCriteria;

  ListViewScreen(this.title, this.items, this.bindViewItem,
      {this.searchCriteria});

  @override
  _ListViewScreenState createState() => _ListViewScreenState<T>();
}

class _ListViewScreenState<T> extends State<ListViewScreen> {
  List<T> _filteredList;
  bool _showSearchBar = false;
  String _searchableText = "";
  final _searchBarFieldController = TextEditingController();
  FocusNode _searchBarFieldFocusNode = FocusNode();

  _list() {
    if (_filteredList == null || _filteredList.isEmpty) {
      return Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(16),
            ),
            Image.asset(
              "assets/images/empty.png",
              package: "commons",
            ),
            Padding(
              padding: EdgeInsets.all(8),
            ),
            Text(
              "Empty Collections",
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    } else {
      return Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: _filteredList.length,
              itemBuilder: (context, index) {
                var item = _filteredList[index];
                return widget.bindViewItem(item, index, _searchableText);
              },
            ),
          ),
        ],
      );
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _filteredList = widget.items;
    });
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _showSearchBar
            ? Theme.of(context).appBarTheme.color
            : Theme.of(context).primaryColor,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
//            color: _showSearchBar ? Theme.of(context).accentIconTheme.color : Colors.white,
          ),
          onPressed: () {
            if (_showSearchBar) {
              setState(() {
                _showSearchBar = !_showSearchBar;
                _searchableText = "";
              });
              _searchBarFieldController.clear();
              _filteredList = widget.items;
            } else {
              pop(context);
            }
          },
        ),
        title: _showSearchBar
            ? TextField(
                maxLength: 30,
                focusNode: _searchBarFieldFocusNode,
                controller: _searchBarFieldController,
                keyboardType: TextInputType.text,
                textAlign: TextAlign.left,
                textInputAction: TextInputAction.search,
                onChanged: (value) {
                  setState(() {
                    _searchableText = value.trim();
                  });
                  if (widget.searchCriteria != null) {
                    if (value != null && value.isNotEmpty) {
                      setState(() {
                        _filteredList = widget.items
                            .where((item) =>
                                widget.searchCriteria(item, _searchableText))
                            .toList();
                      });
                    } else {
                      setState(() {
                        _filteredList = widget.items;
                      });
                    }
                  }
                },
                decoration: InputDecoration(
                  hintText: 'Search...',
                  border: InputBorder.none,
                  counterText: "",
                ),
              )
            : Text(widget.title),
        centerTitle: !_showSearchBar,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              _showSearchBar ? Icons.clear : Icons.search,
//              color: _showSearchBar ? Theme.of(context).accentIconTheme.color : Colors.white,
            ),
            onPressed: () {
              if (_showSearchBar) {
                _searchableText = "";
                _searchBarFieldController.clear();
                _filteredList = widget.items;
              }

              setState(() {
                _showSearchBar = !_showSearchBar;
              });

              delay(Duration(milliseconds: 100), () {
                if (_showSearchBar) {
                  FocusScope.of(context).requestFocus(_searchBarFieldFocusNode);
                } else {
                  FocusScope.of(context).requestFocus(FocusNode());
                }
              });
            },
          ),
        ],
      ),
      body: _list(),
    );
  }
}
