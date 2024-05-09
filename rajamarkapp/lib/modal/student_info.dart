class StudentInfo {
  String studentID;
  String studentName;
  List<String> studentAnswers;

  StudentInfo({
    required this.studentID,
    required this.studentName,
    required this.studentAnswers,
  });
}

StudentInfo parseInputString(String input) {
  String studentID = '';
  String studentName = '';
  List<String> studentAnswers = [];

  List<String> lines = input.split('\n');

  for (String line in lines) {
    String normalizedLine = line.trim().toLowerCase();

    if (normalizedLine.startsWith('student id')) {
      studentID = extractValue(line);
    }

    if (normalizedLine.startsWith('student name')) {
      studentName = extractValue(line);
    }

    // Attempt to extract student answers (assuming answers start with a digit followed by a space and a letter)
     List<String> tokens = normalizedLine.split(RegExp(r'\s+')).where((token) => token.isNotEmpty).toList();
    if (tokens.isNotEmpty && RegExp(r'^\d+$').hasMatch(tokens.first)) {
      // Extract individual answer choices
      for (int i = 0; i < tokens.length; i += 2) {
        if (i + 1 < tokens.length) {
          String answer = tokens[i] + ' ' + tokens[i + 1]; // Combine question number and answer choice
          studentAnswers.add(answer);
        }
      }
    }
  }

  return StudentInfo(
    studentID: studentID.trim(),
    studentName: studentName.trim(),
    studentAnswers: studentAnswers,
  );
}

// Helper function to extract the value after the ':' character
String extractValue(String line) {
  int colonIndex = line.indexOf(':');
  if (colonIndex != -1) {
    return line.substring(colonIndex + 1).trim();
  }
  return '';
}