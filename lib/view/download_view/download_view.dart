import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moben/controller/reader_controller.dart';
import 'package:moben/core/utils/styles.dart';
import 'package:path_provider/path_provider.dart';

class DownloadView extends StatelessWidget {
  final ReaderController readerController = Get.put(ReaderController());

  DownloadView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('اختر القارئ'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Number of columns
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 2,
        ),
        itemCount: readerController.downloadReaderNames.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              readerController.setDownloadSelectedReader(newIndex: index);
              Get.to(() => ReaderSurahListView(
                  readerName: readerController.downloadReaderNames[index]));
            },
            child:  Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    readerController.downloadReaderNames[index],
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),

          );
        },
      ),
    );
  }
}

class ReaderSurahListView extends StatefulWidget {
  final String readerName;

  const ReaderSurahListView({required this.readerName, Key? key})
      : super(key: key);

  @override
  _ReaderSurahListViewState createState() => _ReaderSurahListViewState();
}

class _ReaderSurahListViewState extends State<ReaderSurahListView> {
  List<File> downloadedSurahs = [];

  @override
  void initState() {
    super.initState();
    _fetchDownloadedSurahs();
  }

  Future<void> _fetchDownloadedSurahs() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String readerFolderPath = '${appDocDir.path}/${widget.readerName}';
    Directory readerFolder = Directory(readerFolderPath);

    if (await readerFolder.exists()) {
      setState(() {
        downloadedSurahs = readerFolder.listSync().whereType<File>().toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Downloaded Surahs - ${widget.readerName}'),
      ),
      body: downloadedSurahs.isEmpty
          ? const Center(child: Text('No downloaded Surahs'))
          : ListView.builder(
              itemCount: downloadedSurahs.length,
              itemBuilder: (context, index) {
                final surahFile = downloadedSurahs[index];
                final surahName =
                    surahFile.path.split('/').last.replaceAll('.mp3', '');

                return ListTile(
                  title: Text(surahName,style: AppStyles.textStyle27,),
                  trailing: IconButton(
                    icon: const Icon(Icons.play_arrow),
                    onPressed: () {
                      // Implement play audio logic here
                      print('Playing Surah: $surahName');
                    },
                  ),
                );
              },
            ),
    );
  }
}
