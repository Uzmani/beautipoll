require 'faker'

 User.create :name => 'Dev Bootcamp Student', :email => 'me@example.com', :password => 'password'
 5.times do
   User.create :name => Faker::Name.name, :email => Faker::Internet.email, :password => 'password'
 end

survey = Survey.create({
  title: "Random Survey",
  url: "awf32232",
  user: User.find(1)
  })

question1 = Question.create({
  content: "How many bags of tropical mix can Jeff eat?",
  survey: survey
  })

question2 = Question.create({
  content: "What's Jeremy's favorite bicycling route?",
  survey: survey
  })

choice1q1 = Choice.create({
  content: "1",
  question: question1
  })

choice2q1 = Choice.create({
  content: "2",
  question: question1
  })

choice1q2 = Choice.create({
  content: "Portola Loop",
  question: question2
  })

choice2q2 = Choice.create({
  content: "Anywhere in France",
  question: question2
  })

completed_survey = CompletedSurvey.create({
  survey: survey,
  user: User.find(1)
  })

100.times do
  Reply.create({
    choice: [choice1q1, choice2q1, choice1q2, choice2q2].sample,
    completed_survey: completed_survey
  })
end
# create a few users

#TODO: Once you have implemented BCrypt - you can use these to seed your database.



