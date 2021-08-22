import 'package:crowd_funding_app/Models/notification.dart';

final mockNotificationsJson = ''' [
    {
        "recipients": [
            "61014ae8b04ab400159386f4"
        ],
        "viewed": [],
        "_id": "610d38e8b09239001533ba6e",
        "notificationType": "Donation",
        "title": "Fundraising for business[Donation]",
        "content": "Abex Kebee donated 250 birr.",
        "target": "6103c7a3f737a5001591b0f5",
        "date": "2021-08-06T13:28:08.933Z",
        "__v": 0
    },
    {
        "recipients": [
            "61014ae8b04ab400159386f4"
        ],
        "viewed": [],
        "_id": "6114178f30c2c900153a688e",
        "notificationType": "Team Member",
        "title": "Membership invitation",
        "content": "Nardos hfhdhfh has accepted your invitation to join the team of your fundraiser 'fianal story not working'",
        "target": "6102a8b2afcd390015bdbc7c",
        "date": "2021-08-11T18:31:43.347Z",
        "__v": 0
    }]''';

final mockNotication = UserNotification(
  content: "Mock content",
  date: "2021-09-09",
  fundraiser: '1234567789',
  id: '12345678',
  recipients: ['1234567'],
  title: 'Mock title',
  type: "Donation",
  viewed: ['123456789'],
);
