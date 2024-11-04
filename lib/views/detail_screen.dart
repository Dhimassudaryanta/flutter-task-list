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
    final bool completed = arguments?['data']?.isCompleted ?? false;

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
              margin: EdgeInsets.only(right: 20.0, left: 20.0, top: 32.0),
              child: Text(
                '$title',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 20.0, left: 20.0, top: 36.0),
              child: Text(
                '$description',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 20.0, left: 20.0, top: 50.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Is Completed ?',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                  ),
                  Icon(
                    completed ? Icons.check_circle : Icons.clear_rounded,
                    color: completed ? Colors.green : Colors.red,
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
