import 'package:flutter/material.dart';

class Layout extends StatefulWidget {
  const Layout({Key? key}) : super(key: key);

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isMobile = constraints.maxWidth <= 600;
        bool isDesktop = constraints.maxWidth > 600;

        return Scaffold(
          appBar: isMobile ? AppBar(title: Text('mobile')) : null,
          body: Row(children: [
            if (isDesktop)
              Container(
                width: 200,
                height: double.infinity,
                color: Colors.red,
                child: const Text('slidebar'),
              ),
            Expanded(
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.yellowAccent,
                child: Text('Body'),
              ),
            )
          ]),
        );
      },
    );
  }
}
