class Question < ActiveRecord::Base
  validates :body, presence: true
  validates :poll_id, presence: true

  has_many :answer_choices,
    class_name: "AnswerChoice",
    foreign_key: :question_id,
    primary_key: :id

  belongs_to :poll,
    class_name: "Poll",
    foreign_key: :poll_id,
    primary_key: :id

  has_many :responses, through: :answer_choices, source: :responses

  def results
    results = Hash.new(0)
    self.answer_choices.includes(:responses).each do |answer_choice|
      results[answer_choice] = answer_choice.responses.count
    end
    results
  end
end
