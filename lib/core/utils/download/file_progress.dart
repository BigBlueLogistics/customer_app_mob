import 'package:flutter/material.dart';
import 'package:customer_app_mob/core/utils/download/file_download.dart';

class DownloadProgressDialog extends StatefulWidget {
  const DownloadProgressDialog(
      {super.key,
      required this.url,
      required this.filename,
      this.queryParameters});

  final String url;
  final String filename;
  final Map<String, dynamic>? queryParameters;

  @override
  State<DownloadProgressDialog> createState() => _DownloadProgressDialogState();
}

class _DownloadProgressDialogState extends State<DownloadProgressDialog> {
  double progress = 0.0;

  @override
  void initState() {
    _startDownload();
    super.initState();
  }

  void _startDownload() {
    FileDownload(
            url: widget.url,
            filename: widget.filename,
            queryParameters: widget.queryParameters)
        .startDownloading(context, (recivedBytes, totalBytes) {
      setState(() {
        progress = recivedBytes / totalBytes;
      });
    });
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
