import 'package:darpan/theme/responsive_utils.dart';
import '../../../file_exporter.dart';
part 'event_view_model.dart';
part 'event_view_components.dart';

class EventView extends StatelessWidget {
  const EventView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<EventViewModel>.reactive(
      viewModelBuilder: () => EventViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Column(
                children: [
                  const Align(
                      alignment: Alignment.bottomLeft,
                      child: SectionText(title: "Ongoing Events")),
                  Card(
                    clipBehavior: Clip.hardEdge,
                    shape: ShapeBorder.lerp(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                        1),
                    child: Stack(
                      children: [
                        // Event Image and Info
                        const EventCardInfo(),
                        // Event Date
                        EventDateContainer(
                          top: 120.wWise,
                          left: 20.wWise,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
