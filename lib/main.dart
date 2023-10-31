import 'dart:developer';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GlobalKey box = GlobalKey();
  double heightBox = 0;
  int menuSelected = 0;
  bool menuStatus = false;

  getSizes() {
    heightBox = (box.currentContext?.size?.width ?? 0) * 1.25;

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => getSizes());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Main Page'),
            Text(
              'Welcome',
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text('Add'),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  3,
                  (index) => Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: 15,
                        right: index == 2 ? 0 : 7.5,
                        left: index == 0 ? 0 : 7.5,
                      ),
                      child: Container(
                        key: index == 0 ? box : null,
                        height: heightBox,
                        width: 100,
                        color: Theme.of(context).primaryColor,
                        child: Center(
                            child: Text(
                          'C${index + 1}',
                          style: TextStyle(
                            color: Theme.of(context).secondaryHeaderColor,
                          ),
                        )),
                      ),
                    ),
                  ),
                ).toList(),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 100,
              ),
            ),
            SliverList.builder(
              itemCount: 20,
              itemBuilder: (context, index) {
                return ExpansionPanelList(
                  animationDuration: const Duration(milliseconds: 200),
                  elevation: 1,
                  children: [
                    ExpansionPanel(
                      canTapOnHeader: true,
                      body: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Information',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                TextButton(
                                  onPressed: () {
                                    print('Menu ${index + 1}');
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                            Text('Name     ${index + 1}'),
                            Text('Address ${index + 1}'),
                          ],
                        ),
                      ),
                      headerBuilder: (BuildContext context, bool isExpanded) {
                        return Container(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            'Menu ${index + 1}',
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        );
                      },
                      isExpanded: index == menuSelected && menuStatus,
                    )
                  ],
                  expansionCallback: (int item, bool status) {
                    log(item.toString());

                    menuSelected = index;
                    menuStatus = status;

                    setState(() {});
                  },
                );
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
