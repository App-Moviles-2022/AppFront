import 'package:flutter/material.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';


class AnnouncementDetails extends StatelessWidget {
  // const AnnouncementDetails({Key? key}) : super(key: key);
  AnnouncementDetails(this.announcement_ubication);

  final LatLong announcement_ubication;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Announcement Details"),),
      body:         IgnorePointer(child: OpenStreetMapSearchAndPick(onPicked: (a){},center: LatLong(announcement_ubication.latitude,announcement_ubication.longitude)),
      ),
    );
  }
}
