class Play {
  String? question;
  Map<String, bool> answers;

  Play(this.question, this.answers,);
}
List<Play> questions = [
  Play(
    'Q1. Who created Flutter?',
    {'Facebook':false, 'Adobe':false, 'Google':true, 'Microsoft':false}
),
Play(
  'Q2. What is Flutter.',
  {
    'Android Development Kit': false,
    'IOS Development Kit': false,
    'Web Development Kit': false,
    'SDK to build beautiful IOS, Android, Web & Desktop Native Apps': true,
  }
),
Play(
 ' Q3. Which programing language is used by Flutter!',
    {
      'Ruby':false,
      'Dart':true,
      'C++':false,
      'Kotlin':false,
    }
),
Play(
  'Q4. Who created Dart programing language?',
    {
      'Lars Bak and Kasper Lund':true,
      'Brendan Eich':false,
      'Bjarne Stroustrup':false,
      'Jeremy Ashkenas':false,
    }),
  Play(
     'Q5. Is Flutter cross-platform or not?',
      {'True': true,
        'False': false,
      }
      ),

  Play(
    'Q6. Which of the following best explains the flutter!',
      {
      'It is an open-source database management system':false,
      'This is an open-source UI toolkit':true,
      'This is an open-source backend toolkit':false,
      'None of the above':false,
      }
),
Play(
 'Q7. Which of the following is a sequence of asynchronous events!',
    {'Stream': true,
      'Flow': false,
      'Current': false,
      'None of the above': false,
    }
),
Play(
  'Q8. Which one of these operators is called a null-coalescing operator?',
    {
      '? operator': false,
      '?? operator': true,
      '&& operator': false,
      'None of the above':false,
    }
  ),
  Play(
    'Q9. In Flutter, which of the following is used as identifiers for widgets, elements, and semantic nodes?',
      {'Buttons': false,
        'Widgets': false,
        'Keys': true,
        'Streams': false,
      }
      ),
  Play('Q10. How many types of keys are in Flutter name them',
      {'GlobalKey': false,
        'LocalKey': false,
        'Both of them': true,
        'None of the above': false,
      }
  ),
];
