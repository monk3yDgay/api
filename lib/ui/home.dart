import 'package:api/auth/api-client.dart';
import 'package:api/auth/store.dart';
import 'package:api/models/post.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    String api = Provider.of<Store>(context).getApi();

    return SingleChildScrollView(
      child: StreamBuilder<List<Post>>(
        stream: ApiClient(Dio()).getAllPosts("Bearer ${api}"),
        builder: (context, AsyncSnapshot<List<Post>> snapshots) {
          return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshots.data!.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Row(
                    children: [
                      Container(
                        child: Text("${snapshots.data![index].title}"),
                      )
                    ],
                  ),
                );
              });
        },
      ),
    );
  }
}
