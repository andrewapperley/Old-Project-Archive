// Copyright (c) 2012, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:html';
import 'dart:math' show Random;
import 'dart:convert' show JSON;
import 'dart:async' show Future;

ButtonElement genButton;
SpanElement badgeNameElement;

final String TREASURE_KEY = "pirateName";

void main() {
  InputElement inputField = querySelector('#inputName');
  // Your app starts here.
  inputField.onInput.listen(updateBadge);
  genButton = querySelector('#generateButton');
  genButton.onClick.listen(generateBadge);
  badgeNameElement = querySelector('#badgeName');

  PirateName.readyThePirates()
    .then((_) {
    // on success
    inputField.disabled = false;
    genButton.disabled = false;
    setBadgeName(getBadgeNameFromStorage());
  }).catchError((arrr) {
    print('Error initializing pirate names: $arrr');
    badgeNameElement.text = 'Arrr! No names.';
  });


}

void setBadgeName(PirateName newName) {
  if (newName != null) {
    querySelector('#badgeName').text = newName.pirateName;
    window.localStorage[TREASURE_KEY] = newName.jsonString;
  }
}

PirateName getBadgeNameFromStorage() {
  String storedName = window.localStorage[TREASURE_KEY];
  return (storedName == null) ? null : new PirateName.fromJSON(storedName);
}

void generateBadge(Event e) {
  setBadgeName(new PirateName());
}

void updateBadge(Event e) {
  String newName = (e.target as InputElement).value;
  setBadgeName(new PirateName(firstName: newName));

  if (newName.trim().isEmpty) {
    genButton..disabled = false
             ..text = "Aye! Gimme a name!";
  } else {
    genButton..disabled = true
             ..text = "Arrr! Write yer name!";
  }
}

class PirateName {
  static final Random indexGen = new Random();
  String _firstName;
  String _appellation;
  static List <String> names = [];
  static List <String> appellations = [];

  PirateName({String firstName, String appellation}) {
    if (firstName == null) {
      _firstName = names[indexGen.nextInt(appellations.length)];
    } else {
      _firstName = firstName;
    }
    if (appellation == null) {
      _appellation = appellations[indexGen.nextInt(appellations.length)];
    } else {
      _appellation = appellation;
    }
  }

  PirateName.fromJSON(String jsonString) {
    Map storedName = JSON.decode(jsonString);
    _firstName = storedName['f'];
    _appellation = storedName['a'];
  }

  static Future readyThePirates() {
    var path = 'pirateNames.json';
    return HttpRequest.getString(path)
      .then(_parsePirateNamesFromJSON);
  }

  static _parsePirateNamesFromJSON(String jsonString) {
    Map pirateNames = JSON.decode(jsonString);
    names = pirateNames['names'];
    appellations = pirateNames['appellations'];
  }

  String get jsonString => JSON.encode({"f": _firstName, "a": _appellation});

  String get pirateName =>
    _firstName.isEmpty ? '' : '$_firstName the $_appellation';

  String toString() => pirateName;

}