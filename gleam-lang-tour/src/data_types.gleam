pub type Sport {
  Basketball
  Football
  Tennis
}

fn sport_to_string(sport: Sport) {
  case sport {
    Basketball -> "basketball"
    Football -> "football"
    Tennis -> "tennis"
  }
}

pub type University {
  Base
  Nile
  Unilag
}

pub type Person {
  Athelete(name: String, sport: Sport)
  Student(name: String, university: University)
}

fn university_to_string(university: University) {
  case university {
    Base -> "Base University of Nigeria"
    Nile -> "Nile University of Nigeria"
    Unilag -> "University of Lagos"
  }
}

pub fn custom_greeting(person: Person) -> String {
  case person {
    Athelete(name, sport) ->
      "hi my name is "
      <> name
      <> " and am an athlete that plays "
      <> sport_to_string(sport)
    Student(_, university) ->
      "greetings i am a student at " <> university_to_string(university)
  }
}
