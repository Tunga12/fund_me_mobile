final mockId = "1w23de45Kml904568nuoMnubkskiiUb8n0n";

final mockUserJson = '''{"email": "mock@example.com",
    "firstName": "Mock",
    "lastName": "Mock",
    "password": "123456789",
    "phoneNumber": "09111223344",
    "_id":"eyJhbGciOiJIUzI1NiIsInR5cCI6Ikp",
    "paymentMethods": "",
    "emailNotification":false,
    "isDeactivated": false,
    "isAdmin": false}
    ''';

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

final mockFundraiseJson = '''{
    "totalItems": 47,
    "fundraisers": [
    {
      "location": {
        "latitude": "0",
        "longitude": "0"
      },
      "donations": [
        
      ],
      "totalRaised": 0,
      "likedBy": [
        
      ],
      "_id": "6139b43808e2b100166d1c1f",
      "goalAmount": 111,
      "title": "wewew we",
      "image": "https://image.com"
      },
      {
      "location": {
        "latitude": "0",
        "longitude": "0"
      },
      "donations": [
        
      ],
      "totalRaised": 0,
      "likedBy": [
        
      ],
      "_id": "6139b43808e2b100166d1c1f",
      "goalAmount": 111,
      "title": "wewew we",
      "image": "https://image.com"
      },
      {
      "location": {
        "latitude": "0",
        "longitude": "0"
      },
      "donations": [
        
      ],
      "totalRaised": 0,
      "likedBy": [
        
      ],
      "_id": "6139b43808e2b100166d1c1f",
      "goalAmount": 111,
      "title": "wewew we",
      "image": "https://image.com"
      }
    ],
    "totalPages": 5,
    "currentPage": 0,
    "hasNextPage": true,
    "hasPrevPage": false
}
''';

final mockCategoriesJson =
    '[{"_id": "As13DcbFg234", "name": "mock1"}, {"_id": "Dfra341o09d", "name": "mock2"}]';

final mockFundraiserDetailJson = """
{
  "location": {
    "latitude": "0",
    "longitude": "0"
  },
  "updates": [
    
  ],
  "totalRaised": 0,
  "isPublished": true,
  "totalShareCount": 0,
  "likeCount": 0,
  "likedBy": [
    
  ],
  "isBlocked": false,
  "_id": "6139b43808e2b100166d1c1f",
  "donations": [
    
  ],
  "goalAmount": 111,
  "category": {
    "_id": "60f355be9628ca0015b3c994",
    "name": "Business"
  },
  "title": "wewew we",
  "story": "<p>wewewewdfdf dfkd fkdf fkd</p>",
  "image": "https://image.com/",
  "organizer": {
    "_id": "611e1c984f8679001694271e",
    "firstName": "Getachew",
    "lastName": "Tebikew",
    "email": "getachewtbkw@gmail.com"
  },
  "teams": [
    {
      "status": "accepted",
      "_id": "6139b43808e2b100166d1c20",
      "id": {
        "hasRaised": 0,
        "shareCount": 0,
        "_id": "6139b43808e2b100166d1c1e",
        "userId": {
          "_id": "611e1c984f8679001694271e",
          "firstName": "Getachew",
          "lastName": "Tebikew",
          "email": "getachewtbkw@gmail.com"
        }
      },
      "userId": "611e1c984f8679001694271e"
    }
  ],
  "dateCreated": "2021-09-09T07:14:00.939Z",
  "totalWithdraw": [
    
  ]
}
""";
