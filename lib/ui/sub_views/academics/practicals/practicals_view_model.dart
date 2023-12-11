part of 'practicals_view.dart';

class PracticalsViewModel extends BaseViewModel {
  final log = getLogger('PracticalsViewModel');

  void init() async {
    await loadData();
  }

  final List<PracticalsCard> _practicalsCard = [];
  List<PracticalsCard> get practicalsCard => _practicalsCard;

  Future<void> loadData() async {
    setBusy(true);
    try {
      // _practicalsCard = await _firestoreService.getallPracticalsCards();

      log.i(_practicalsCard[0].title);
      notifyListeners();
    } catch (e) {
      log.e(e);
    }
    setBusy(false);
    log.i("Practical Loaded");
  }

  List<PracticalsCard> allSubCards = [
    const PracticalsCard(
      leading: AssetImagePath.tcsImg,
      title: "Theoretical Computer Science",
    ),
    const PracticalsCard(
      leading: AssetImagePath.seImg,
      title: "Software Engineering",
    ),
    const PracticalsCard(
      leading: AssetImagePath.cnImg,
      title: "Computer Network",
    ),
    const PracticalsCard(
      leading: AssetImagePath.dwmImg,
      title: "Data Warehousing & Mining",
    ),
    const PracticalsCard(
      leading: AssetImagePath.adbmsImg,
      title: "Advance Database Management",
    ),
    const PracticalsCard(
      leading: AssetImagePath.pceImg,
      title: "Professional Comm. & Ethics II",
    ),
  ];
}
