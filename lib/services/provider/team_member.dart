import 'dart:io';

import 'package:crowd_funding_app/Models/status.dart';
import 'package:crowd_funding_app/Models/team_member.dart';
import 'package:crowd_funding_app/services/repository/tean_member.dart';
import 'package:flutter/material.dart';

class TeamMemberModel extends ChangeNotifier {
  final TeamMemberRepository teamMemberRepository;
  TeamMemberModel({
    required this.teamMemberRepository,
  });

  Response _response =
      Response(status: ResponseStatus.LOADING, data: null, message: '');

  Response get response => _response;

  set response(Response response) {
    _response = response;
    notifyListeners();
  }

  Future createTeamMember(
      String email, String token, String fundraiseId) async {
    try {
      response =
          Response(status: ResponseStatus.LOADING, data: null, message: '');
      final data = await teamMemberRepository.createTeamMember(
          email, token, fundraiseId);
      if (data)
        response = Response(
            status: ResponseStatus.SUCCESS, data: data, message: "success");
      notifyListeners();
    } on SocketException catch (e) {
      print("teammeber Error ${e.message}");
      response = Response(
          status: ResponseStatus.CONNECTIONERROR,
          data: null,
          message: "No internet connection");
    } on FormatException catch (e) {
      print('teamMember ${e.message}');
      response = Response(
          status: ResponseStatus.FORMATERROR,
          data: null,
          message: "Invalid response from the server");
    } catch (e) {
      response = Response(
          status: ResponseStatus.MISMATCHERROR,
          data: '',
          message: e.toString().substring(10));
    }
  }

  Future verifyTeamMember(bool status, String token, String fundraiseId) async {
    try {
      response =
          Response(status: ResponseStatus.LOADING, data: null, message: '');
      final data = await teamMemberRepository.verifyTeamMember(
          status, token, fundraiseId);
      response = Response(
          status: ResponseStatus.SUCCESS, data: data, message: "success");
    } on SocketException catch (e) {
      print("teammeber Error ${e.message}");
      response = Response(
          status: ResponseStatus.CONNECTIONERROR,
          data: null,
          message: "No internet connection");
    } on FormatException catch (e) {
      print('teamMember ${e.message}');
      response = Response(
          status: ResponseStatus.FORMATERROR,
          data: null,
          message: "Invalid response from the server");
    } catch (e) {
      print("Teammember error ${e.toString()}");
    }
  }

  // delete team fundraiser
  Future deleteTeamMember(String token, String memberId) async {
    try {
      response =
          Response(status: ResponseStatus.LOADING, data: null, message: '');
      final data = await teamMemberRepository.deleteFundraiser(token, memberId);
      if (data)
        response = Response(
            status: ResponseStatus.SUCCESS, data: data, message: "success");
    } on SocketException catch (e) {
      print("teammeber Error ${e.message}");
      response = Response(
          status: ResponseStatus.CONNECTIONERROR,
          data: null,
          message: "No internet connection");
    } on FormatException catch (e) {
      print('teamMember ${e.message}');
      response = Response(
          status: ResponseStatus.FORMATERROR,
          data: null,
          message: "Invalid response from the server");
    } catch (e) {
      print("Teammember error ${e.toString()}");
      response = Response(
          status: ResponseStatus.MISMATCHERROR,
          data: '',
          message: 'unable to delete member');
    }
  }
}
