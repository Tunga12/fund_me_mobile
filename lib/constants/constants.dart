import 'package:flutter/material.dart';

final inputDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 5.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(7.0),
    borderSide: BorderSide(width: 7.0),
  ),
);

String? inputValidator(String? value) {
  if (value!.isEmpty) {
    return 'field required';
  } else if (value.length < 3) {
    return 'field should be atleast 3 chars';
  }
}

List<String> months = [
  "Month",
  '01',
  "02",
  "03",
  "04",
  "05",
  "06",
  "07",
  "08",
  "09",
  '10',
  '11',
  "12",
];

List<String> days = [
  'Day',
  '01',
  "02",
  "03",
  "04",
  "05",
  "06",
  "07",
  "08",
  "09",
  '10',
  '11',
  "12",
  '13',
  '14',
  '15',
  "16",
  '17',
  '18',
  '19',
  '20',
  '21',
  '22',
  '23',
  '24',
  '25',
  '26',
  '27',
  '28',
  '29',
  '30',
  '31'
];

List<String> years = [
  'Year',
  '2021',
  '2020',
  '2019',
  '2018',
  '2017',
  '2016',
  '2015',
  '2014',
  '2013',
  '2012',
  '2011',
  '2010',
  '2009',
  '2008',
  '2007',
  '2006',
  '2005',
  '2004',
  '2003',
  '2002',
  '2001',
  '2000',
  '1999',
  '1998',
  '1997',
  '1996',
  '1995',
  '1994',
  '1993',
  '1992',
  '1991'
];
