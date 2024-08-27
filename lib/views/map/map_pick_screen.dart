import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MapPickScreen extends StatelessWidget {
  const MapPickScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('FAB Popup Example'),
      ),
      body: const Center(
        child: Text('Press the FAB to see the options.'),
      ),
      floatingActionButton: Builder(
        builder: (context) => FloatingActionButton(
          onPressed: () {
            final RenderBox fab = context.findRenderObject() as RenderBox;
            final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;

            final RelativeRect position = RelativeRect.fromRect(
              Rect.fromPoints(
                fab.localToGlobal(fab.size.topLeft(Offset.zero), ancestor: overlay),
                fab.localToGlobal(fab.size.topRight(Offset.zero), ancestor: overlay),
              ),
              Offset.zero & overlay.size,
            );

            showMenu(
              context: context,
              position: position.shift(Offset(0, -fab.size.height)),
              items: [
                const PopupMenuItem(
                  value: 'add_data',
                  child: Text('Add Data'),
                ),
                const PopupMenuItem(
                  value: 'edit_coordinates',
                  child: Text('Edit Coordinates'),
                ),
              ],
            ).then((value) {
              if (value == 'add_data') {
                print('Add Data selected');
              } else if (value == 'edit_coordinates') {
                print('Edit Coordinates selected');
              }
            });
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
