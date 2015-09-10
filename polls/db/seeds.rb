# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

sean = User.create!(user_name: "Sean")
vic = User.create!(user_name: "Vic")

ruby_poll = Poll.create!(title: "Ruby", author: vic)

ruby_question = Question.create!(body: "Do you like Ruby?", poll: ruby_poll )
rails_question = Question.create!(body: "What is your favorite Rails feature?", poll: ruby_poll)

ruby_answer_1 = AnswerChoice.create!(body: "Yes", question: ruby_question)
ruby_answer_2 = AnswerChoice.create!(body: "No", question: ruby_question)

ruby_response_1 = Response.create!(answer_choice: ruby_answer_1, respondent: sean)
