import 'package:console/console.dart';
import 'package:solfege/console_utils.dart';

final List<String> chromaticScale = List.unmodifiable([
  'A',
  'A#',
  'B',
  'C',
  'C#',
  'D',
  'D#',
  'E',
  'F',
  'F#',
  'G',
  'G#',
]);

final List<int> majorScaleIndexes = List.unmodifiable([
  0, 2, 4, 5, 7, 9, 11
]);

final List<String> solfege = List.unmodifiable([
  "do",
  "re",
  "mi",
  "fa",
  "so",
  "la",
  "ti",
]);

void main() {
  Console.init();

  Console.setTextColor(ConsoleColor.blue.index);
  Console.write("\n*******");
  Console.write("\nSOLFEGE");
  Console.write("\n*******\n");

  final tonic = promptForString("Enter a key: ").toUpperCase();
  final solfegeName = promptForString("Enter a solfege name: ");

  final keyedChromaticScale = createChromaticScale(tonic);
  final majorScale = createMajorScale(keyedChromaticScale);
  final note = getNoteFromSolfege(solfegeName, majorScale);

//  print(keyedChromaticScale);
//  print(majorScale);
  Console.setTextColor(ConsoleColor.red.index);
  Console.write("\nIn the key of $tonic, \"$solfegeName\" is: $note");
}

List<String> createChromaticScale(String tonic) {
  final List<String> newChromaticScale = [];

  final tonicIndex = chromaticScale.indexOf(tonic);

  // don't recreate a chromatic scale we already have, this is the edge case
  if (tonicIndex == 0) {
    return chromaticScale;
  }

  for (int i = tonicIndex; i < tonicIndex + chromaticScale.length; i++) {
    final sourceIndex = (i < chromaticScale.length ? i : i - chromaticScale.length);
    newChromaticScale.add(chromaticScale[sourceIndex]);
  }

  return List.unmodifiable(newChromaticScale);
}

List<String> createMajorScale(List<String> chromaticScale) {
//  final List<String> majorScale = [];
//
//  for (int sourceIndex in majorScaleIndexes) {
//    majorScale.add(chromaticScale[sourceIndex]);
//  }

  final majorScale = majorScaleIndexes.map((int index) => chromaticScale[index]);

  return List.unmodifiable(majorScale);
}

String getNoteFromSolfege(String solfegeName, List<String> majorScale) {
  // find the index of the solfegeName in the solfege list
  final solfegeIndex = solfege.indexOf(solfegeName.toLowerCase());

  // return the note at the same index from the majorscale
  return majorScale[solfegeIndex];
}
