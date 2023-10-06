import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:uts/edit_data.dart';
import 'package:uts/side_menu.dart';
import 'package:uts/tambah_data.dart';

class ListData extends StatefulWidget {
  const ListData({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ListDataState createState() => _ListDataState();
}

class _ListDataState extends State<ListData> {
  List<Map<String, String>> dataPekerjaan = [];
  String url = 'http://localhost/api-flutter/index.php';

  // String url = 'http://localhost/api-flutter/index.php';
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        dataPekerjaan = List<Map<String, String>>.from(data.map((item) {
          return {
            'nama': item['nama'] as String,
            'status': item['status'] as String,
            'id': item['id'] as String,
          };
        }));
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future deleteData(int id) async {
    final response = await http.delete(Uri.parse('$url?id=$id'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to delete data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Data Pekerjaan'),
      ),
      drawer: const SideMenu(),
      body: Column(children: <Widget>[
        ElevatedButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const TambahData(),
              ),
            );
          },
          child: const Text('Tambah Data Pekerjaan'),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: dataPekerjaan.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(dataPekerjaan[index]['nama']!),
                subtitle: Text('Status: ${dataPekerjaan[index]['status']}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.visibility),
                      onPressed: () {
                        lihatPekerjaan(context, index);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        editPekerjaan(context, index);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        deleteData(int.parse(dataPekerjaan[index]['id']!))
                            .then((result) {
                          if (result['pesan'] == 'berhasil') {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text('Data berhasil di hapus'),
                                    content: const Text(''),
                                    actions: [
                                      TextButton(
                                        child: const Text('OK'),
                                        onPressed: () {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const ListData(),
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  );
                                });
                          }
                        });
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        )
      ]),
    );
  }

  void editPekerjaan(BuildContext context, int index) {
    final Map<String, dynamic> pekerjaan = dataPekerjaan[index];
    final String id = pekerjaan['id'] as String;
    final String nama = pekerjaan['nama'] as String;
    final String status = pekerjaan['status'] as String;

    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => EditData(id: id, nama: nama, status: status),
    ));
  }

  void lihatPekerjaan(BuildContext context, int index) {
    final pekerjaan = dataPekerjaan[index];
    final nama = pekerjaan['nama'] as String;
    final status = pekerjaan['status'] as String;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          titlePadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
          title: const Center(child: Text('Detail Pekerjaan')),
          content: SizedBox(
            height: 50,
            child: Column(
              children: [
                Text('Nama : $nama'),
                Text('Status: $status'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
