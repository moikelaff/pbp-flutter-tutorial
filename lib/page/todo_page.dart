import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:pbp_flutter/model/todo.dart';
import 'package:pbp_flutter/main.dart';
import 'package:pbp_flutter/page/form.dart';
import 'package:flutter/material.dart';


class todoPage extends StatefulWidget {
    const todoPage({Key? key}) : super(key: key);

    @override
    _todoPageState createState() => _todoPageState();
}

class _todoPageState extends State<todoPage> {
    Future<List<todo>> fetchtodo() async {
        var url = Uri.parse('https://jsonplaceholder.typicode.com/todos?_start=0&_limit=10');
        var response = await http.get(
        url,
        headers: {
            "Access-Control-Allow-Origin": "*",
            "Content-Type": "application/json",
        },
        );

        // melakukan decode response menjadi bentuk json
        var data = jsonDecode(utf8.decode(response.bodyBytes));

        // melakukan konversi data json menjadi object todo
        List<todo> listtodo = [];
        for (var d in data) {
        if (d != null) {
            listtodo.add(todo.fromJson(d));
        }
        }

        return listtodo;
    }
    
      @override
      Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(
              title: const Text('To Do'),
          ),
    drawer: Drawer(
        child: Column(
        children: [
            // Menambahkan clickable menu
            ListTile(
            title: const Text('Counter'),
            onTap: () {
                // Route menu ke halaman utama
                Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const MyApp()),
                );
            },
            ),
            ListTile(
            title: const Text('Form'),
            onTap: () {
                // Route menu ke halaman form
                Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const MyFormPage()),
                );
            },
            ),
            ListTile(
            title: const Text('To Do'),
            onTap: () {
                // Route menu ke halaman to do
                Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const todoPage()),
                );
              },
            ),
          ],
        ),
    ),
    body: FutureBuilder(
        future: fetchtodo(),
        builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
            return const Center(child: CircularProgressIndicator());
            } else {
            if (!snapshot.hasData) {
                return Column(
                children: const [
                    Text(
                    "Tidak ada to do list :(",
                    style: TextStyle(
                        color: Color(0xff59A5D8),
                        fontSize: 20),
                    ),
                    SizedBox(height: 8),
                ],
                );
            } else {
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (_, index)=> Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    padding: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                        color:Colors.white,
                        borderRadius: BorderRadius.circular(15.0),
                        boxShadow: const [
                        BoxShadow(
                            color: Colors.black,
                            blurRadius: 2.0
                        )
                        ]
                    ),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        Text(
                            "${snapshot.data![index].title}",
                            style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            ),
                        ),
                        const SizedBox(height: 10),
                        Text("${snapshot.data![index].completed}"),
                        ],
                    ),
                    )
                );
              }
            }
          }
        )
      );
      }
}