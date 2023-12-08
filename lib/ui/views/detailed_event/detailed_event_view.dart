import 'package:darpan/file_exporter.dart';

part 'detailed_event_view_model.dart';

class DetailedEventView extends StatelessWidget {
  const DetailedEventView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DetailedEventViewModel>.nonReactive(
      viewModelBuilder: () => DetailedEventViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: Colors.amber,
          body: Text("Hello world"),
        );
      },
    );
  }
}
