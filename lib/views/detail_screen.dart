import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;

    final String title = arguments?['data']?.title ?? 'Default Title';
    final String description =
        arguments?['data']?.description ?? 'Default Description';

    print(arguments['data'].title);
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.all(8.0),
              child: Text(
                '$title',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(8.0),
              child: Text(
                '$description',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    'Is Completed ?',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  Icon(
                    Icons.check,
                    color: Colors.green,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
