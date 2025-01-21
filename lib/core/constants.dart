class QuizData {
  final String filename;
  final List<Mcq> mcqs;
  final List<Flashcard> flashcards;

  QuizData({
    required this.filename,
    required this.mcqs,
    required this.flashcards,
  });

  factory QuizData.fromJson(Map<String, dynamic> json) {
    return QuizData(
      filename: json['filename'],
      mcqs: List<Mcq>.from(json['mcqs'].map((x) => Mcq.fromJson(x))),
      flashcards: List<Flashcard>.from(json['flashcards'].map((x) => Flashcard.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'filename': filename,
      'mcqs': List<dynamic>.from(mcqs.map((x) => x.toJson())),
      'flashcards': List<dynamic>.from(flashcards.map((x) => x.toJson())),
    };
  }
}

class Mcq {
  final String question;
  final List<String> options;
  final String correctAnswer;
  final String explanation;

  Mcq({
    required this.question,
    required this.options,
    required this.correctAnswer,
    required this.explanation,
  });

  factory Mcq.fromJson(Map<String, dynamic> json) {
    return Mcq(
      question: json['question'],
      options: List<String>.from(json['options']),
      correctAnswer: json['correct_answer'],
      explanation: json['explanation'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'question': question,
      'options': options,
      'correct_answer': correctAnswer,
      'explanation': explanation,
    };
  }
}

class Flashcard {
  final String front;
  final String back;

  Flashcard({
    required this.front,
    required this.back,
  });

  factory Flashcard.fromJson(Map<String, dynamic> json) {
    return Flashcard(
      front: json['front'],
      back: json['back'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'front': front,
      'back': back,
    };
  }
}

// Future<void> loadJson() async {
//   String jsonString = await rootBundle.loadString('assets/data.json');
//   var jsonData = jsonDecode(jsonString);
//   if (kDebugMode) {
//     print(jsonData);
//   } // Use your data here
// }

const String jsonString = '''
{
    "filename": "Chapter 1. Introduction to DBMS.pdf",
    "mcqs": [
        {
            "question": "According to the text, what are the two main components of a Database Management System?",
            "options": [
                "A. Data and Programs",
                "B. Database and File System",
                "C. Database and Management System",
                "D. Records and Tables"
            ],
            "correct_answer": "C",
            "explanation": "The text explicitly states that a Database Management System consists of two parts: Database and Management System."
        },
        {
            "question": "In the context of a database, what term is used to describe the columns of a table or relation?",
            "options": [
                "A. Tuples",
                "B. Records",
                "C. Fields/Attributes/Domains",
                "D. Relations"
            ],
            "correct_answer": "C",
            "explanation": "The text explains that the columns of a relation are called Fields, Attributes, or Domains."
        },
        {
            "question": "What is the primary goal of a Database Management System (DBMS) according to the text?",
            "options": [
                "A. To manage large bodies of information only",
                "B. To ensure data safety despite system crashes only",
                "C. To provide a way to store and retrieve database information that is both convenient and efficient",
                "D. To avoid anomalous results when data is shared among users"
            ],
            "correct_answer": "C",
            "explanation": "The text explicitly mentions that the primary goal of a DBMS is to provide a way to store and retrieve database information that is both convenient and efficient."
        },
        {
            "question": "Based on the text, which of the following best describes 'data' in the context of a database?",
            "options": [
                "A. A collection of related records.",
                "B. Facts, figures, and statistics with a specific meaning.",
                "C. Facts, figures, and statistics having no particular meaning.",
                "D. A collection of interrelated tables."
            ],
            "correct_answer": "C",
            "explanation": "The text defines data as facts, figures, and statistics having no particular meaning until organized into records."
        },
        {
            "question": "Which of the following is NOT explicitly mentioned as a common application of a Database Management System in the provided text?",
            "options": [
                "A. Sales management",
                "B. Social media platforms",
                "C. University registration systems",
                "D. Airline reservation systems"
            ],
            "correct_answer": "B",
            "explanation": "While the text covers areas like sales, universities and airlines, it does not specifically mention social media platforms as a direct application of a DBMS."
        }
    ],
    "flashcards": [
        {
            "front": "What is a Database?",
            "back": "A database is a structured collection of related data.  It's not just raw data , but organized data with inherent meaning.  This organization is achieved through records (collections of related data items) which are grouped into tables or relations.  These tables are linked, allowing for complex queries across multiple tables to find complete information."
        },
        {
            "front": "What is a Database Management System (DBMS)?",
            "back": "A DBMS is a software system designed to manage databases efficiently. It provides tools to define, create, maintain, and access databases.  A DBMS handles data storage, retrieval, and ensures data integrity, security, and concurrency control (managing multiple users accessing the database simultaneously). It makes interacting with large amounts of data convenient and efficient."
        },
        {
            "front": "What are the key components of a relational database?",
            "back": "A relational database organizes data into tables (also called relations). Each table consists of rows (called tuples or records) and columns (called fields, attributes, or domains).  The columns represent the characteristics of the data (e.g., student ID, name, major), and rows represent individual entries.  Relationships between tables are established through common attributes (fields) shared between them."
        },
        {
            "front": "What are some common applications of DBMS?",
            "back": "DBMS are used across a vast range of applications. Examples include managing enterprise information (sales, accounting, HR), manufacturing (inventory, supply chain), banking (accounts, transactions), universities (student records, grades), airlines (reservations), telecommunications (call records), and web-based services (online shopping, advertising).  Essentially, any application requiring organized, persistent storage and retrieval of large amounts of data benefits from a DBMS."
        },
        {
            "front": "What are different views of a database?",
            "back": "Different users have different perspectives on the same database.  For example, a student might only need to see their own course information, while an administrator might need access to all student records and grades.  A DBMS allows for different views to be created, presenting only the relevant data to specific users, enhancing security and streamlining access based on user roles and responsibilities."
        }
    ]
}
''';  