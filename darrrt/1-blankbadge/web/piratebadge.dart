// Copyright (c) 2012, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
import 'dart:html';
import 'dart:math' show Random;

import 'dart:convert' show JSON;
import 'dart:async' show Future;

final String TREASURE_KEY = 'pirateName';
ButtonElement genButton;
SpanElement badgeNameElement;

Future main() async{
    InputElement inputField = querySelector('#inputName');
    inputField.onInput.listen(updateBadge);

    genButton = querySelector('#generateButton');
    genButton.onClick.listen(generateBadge);

    badgeNameElement = querySelector('#badgeName');

    try {
        await PirateName.readyThePirates();

        inputField.disabled = false; //double negative
        genButton.disabled = false; //double negative
        setBadgeName(getBadgeNameFromStorage());
    } catch (arrr) {
        print('Error initializing pirate names: $arrr');
        badgeNameElement.text = 'Arrr! No names.';
    }

}

void updateBadge(Event e) {
    String inputName = (e.target as InputElement).value;
    setBadgeName(new PirateName(firstName: inputName));
    if (inputName.trim().isEmpty) {
        genButton
            ..disabled = false
            ..text = 'Aye! Gimme a name!';
    } else {
        genButton
            ..disabled = true
            ..text = 'Arrr! Write yer name!';
    }
}

void generateBadge(Event e) {
    setBadgeName(new PirateName());
}

void setBadgeName(PirateName newName) {
    if (newName == null) {
        return;
    }

    querySelector('#badgeName').text = newName.pirateName;
    window.localStorage[TREASURE_KEY] = newName.jsonString;
}

PirateName getBadgeNameFromStorage() {
    String storedName = window.localStorage[TREASURE_KEY];
    if (storedName != null) {
        return new PirateName.fromJSON(storedName);
    } else {
        return null;
    }
}


class PirateName {
    static final Random indexGen = new Random();
    static List<String> names = [];
    static List<String> appellations = [];

    String _firstName;
    String _appellation;

    PirateName({String firstName, String appellation}) {
        if (firstName == null) {
            _firstName = names[indexGen.nextInt(names.length)];
        } else {
            _firstName = firstName;
        }

        if (appellation == null) {
            _appellation = appellations[indexGen.nextInt(appellations.length)];
        } else {
            _appellation = appellation;
        }
    }

    PirateName.fromJSON(String jsonString){
        Map storedName = JSON.decode(jsonString);
        _firstName = storedName['f'];
        _appellation = storedName['a'];
    }

    static Future readyThePirates() async {
        String path = 'piratenames.json';
        String jsonString = await HttpRequest.getString(path);
        _parsePirateNamesFrmJSON(jsonString);
    }

    static _parsePirateNamesFrmJSON(String jsonString) {
        Map pirateNames = JSON.decode(jsonString);
        names = pirateNames['names'];
        appellations = pirateNames['appellations'];
    }

    String toString() => pirateName;

    String get pirateName => _firstName.isEmpty ? '' : '$_firstName the $_appellation';

    String get jsonString => JSON.encode({
        "f": _firstName, "a": _appellation
    });
}
