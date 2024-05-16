import 'package:flutter/material.dart';
import 'package:open_filex/open_filex.dart';
import 'package:customer_app_mob/core/presentation/widgets/organisms/md_download/file_download.dart';

class MDDownloadProgress extends StatefulWidget {
  const MDDownloadProgress(
      {super.key,
      required this.url,
      required this.filename,
      this.queryParameters});

  final String url;
  final String filename;
  final Map<String, dynamic>? queryParameters;

  @override
  State<MDDownloadProgress> createState() => _MDDownloadProgressState();
}

class _MDDownloadProgressState extends State<MDDownloadProgress> {
  double progress = 0.0;
  bool openFileError = false;

  @override
  void initState() {
    _startDownload();
    super.initState();
  }

  void _startDownload() async {
    FileDownload file = FileDownload(
        url: widget.url,
        filename: widget.filename,
        queryParameters: widget.queryParameters);

    file.startDownloading(context, (receivedBytes, totalBytes) async {
      setState(() {
        progress = receivedBytes / totalBytes;
      });
    }, (filePath) async {
      await openFile(filePath);
    });
  }

  Future<void> openFile(String filePath) async {
    if (filePath.isNotEmpty) {
      if (mounted) {
        final mainSnack = ScaffoldMessenger.of(context);

        mainSnack.showSnackBar(
          SnackBar(
            showCloseIcon: true,
            content: const Text('Download complete.'),
            duration: const Duration(seconds: 20),
            backgroundColor: Colors.green.shade300,
            action: SnackBarAction(
              label: 'Open',
              onPressed: () async {
                final res = await OpenFilex.open(filePath);

                if (res.type != ResultType.done) {
                  mainSnack.hideCurrentSnackBar();
                  mainSnack.showSnackBar(
                    SnackBar(
                      duration: const Duration(seconds: 5),
                      content: Text(res.message.toString()),
                    ),
                  );
                }
              },
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    String downloadingProgress = (progress * 100).toInt().toString();
    return AlertDialog(
        content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: const Text(
            'Downloading',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
        LinearProgressIndicator(
          value: progress,
          backgroundColor: Colors.grey,
          color: Colors.green,
          minHeight: 10,
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Text(
            '$downloadingProgress %',
          ),
        )
      ],
    ));
  }
}
