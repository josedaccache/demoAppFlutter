import 'package:flutter/material.dart';
import '../screens/NewsScreen.dart';
import '../screens/SlideShowScreen.dart';
import '../screens/ContactUsScreen.dart';
import '../classes/DrawerItem.dart';
import '../screens/NewsDetailsScreen.dart';
//Let's define a DrawerItem data object

// Our Homepage
class HomePage extends StatefulWidget {
  //Let's Create and Return state for this 'StatefulWidget'
  final drawerItems = [
    new DrawerItem("News", Icons.home),
    new DrawerItem("Contact Us", Icons.mail),
    new DrawerItem("SlideShow", Icons.slideshow)
  ];

  @override
  State<StatefulWidget> createState() {
    return new HomePageState();
  }
}
// Let's define state for our homepage. A state is just information for a widget.
class HomePageState extends State<HomePage> {
  int _selectedDrawerIndex = 0;

  //Let's use a switch statement to return the Fragment for a selected item
  _getDrawerFragment(int pos) {
    switch (pos) {
      case 0:
        return new News();
      case 1:
        return new ContactUs();
      case 2:
        return new SlideShow();

      default:
        return new Text("Error");
    }
  }
  //Let's update the selectedDrawerItemIndex the close the drawer
  _onSelectItem(int index) {
    setState(() => _selectedDrawerIndex = index);
    //we close the drawer
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> drawerOptions = [];
    //Let's create drawer list items. Each will have an icon and text
    for (var i = 0; i < widget.drawerItems.length; i++) {
      var d = widget.drawerItems[i];
      drawerOptions.add(
          new ListTile(
            leading: new Icon(d.icon),
            title: new Text(d.title),
            selected: i == _selectedDrawerIndex,
            onTap: () => _onSelectItem(i),
          )
      );
    }
    //Let's scaffold our homepage
    return new Scaffold(
      appBar: new AppBar(
        // We will dynamically display title of selected page
        title: new Text(widget.drawerItems[_selectedDrawerIndex].title),
      ),
      // Let's register our Drawer to the Scaffold
      drawer: new Drawer(
        child: new Column(
          children: <Widget>[
            DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
            ),
            //Lets Create a material design drawer header with account name, email,avatar
            new Column(children: drawerOptions)
          ],
        ),
      ),
      body: _getDrawerFragment(_selectedDrawerIndex),
    );
  }
}