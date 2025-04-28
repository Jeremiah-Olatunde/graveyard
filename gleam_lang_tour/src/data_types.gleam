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

pub opaque type Person {
  Athelete(name: String, age: Int, sport: Sport)
  Student(name: String, age: Int, university: University)
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
    Athelete(name, _, sport) ->
      "hi my name is "
      <> name
      <> " and am an athlete that plays "
      <> sport_to_string(sport)
    Student(_, _, university) ->
      "greetings i am a student at " <> university_to_string(university)
  }
}

pub fn student(name: String, age: Int, university: University) -> Person {
  Student(name, age, university)
}

pub fn athelete(name: String, age: Int, sport: Sport) -> Person {
  Athelete(name, age, sport)
}

pub fn increment_age(person: Person) -> Person {
  case person {
    Athelete(..) -> Athelete(..person, age: person.age + 1)
    Student(..) -> Student(..person, age: person.age + 1)
  }
}
