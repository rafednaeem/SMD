import 'dart:io';

void main() async {
  final file = File('file.txt');
  if (!await file.exists()) {
    print('File not found!');
    return;
  }

  final lines = await file.readAsLines();
  Map<int, Map<String, int>> lineFrequencies = {};
  Map<int, int> maxFrequencies = {};

  for (var i = 0; i < lines.length; i++) {
    var words = lines[i].toLowerCase().split(RegExp(r'\W+')).where((w) => w.isNotEmpty);
    var frequency = <String, int>{};

    for (var word in words) {
      frequency[word] = (frequency[word] ?? 0) + 1;
    }

    int maxFreq = frequency.values.fold(0, (a, b) => a > b ? a : b);
    lineFrequencies[i + 1] = frequency;
    maxFrequencies[i + 1] = maxFreq;
  }

  int globalMax = maxFrequencies.values.fold(0, (a, b) => a > b ? a : b);
  List<int> highestFrequencyLines = maxFrequencies.entries
      .where((entry) => entry.value == globalMax)
      .map((entry) => entry.key)
      .toList();

  print("The following words have the highest word frequency per line:");
  for (var entry in lineFrequencies.entries) {
    int lineNum = entry.key;
    var highestWords = entry.value.entries.where((e) => e.value == maxFrequencies[lineNum]).map((e) => e.key).toList();
    print("$highestWords (appears in line $lineNum)");
  }

  print("\nLines with the greatest frequency among all:");
  print(highestFrequencyLines);
}
