import 'package:assignment/post/view/post_list_screen.dart';
import 'package:assignment/post/view_model/post_view_model.dart';

import 'package:assignment/post_detail/view_model/post_detail_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: PostViewModel()),
          ChangeNotifierProvider.value(value: PostDetailViewModel()),
        ],
        child :MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const PostListScreen(),
        )
    );
  }
}

