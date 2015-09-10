class Response < ActiveRecord::Base
  validates :user_id, presence: true
  validates :answer_choice_id, presence: true
  validate :respondent_has_not_already_answered_question
  validate :author_can_not_respond_to_own_poll

  belongs_to :answer_choice,
    class_name: "AnswerChoice",
    foreign_key: :answer_choice_id,
    primary_key: :id

  belongs_to :respondent,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id

  has_one :question, through: :answer_choice, source: :question

  def sibling_responses
    self.question.responses.where("? IS NULL OR responses.id != ?", self.id, self.id)
  end

  private
  def respondent_has_not_already_answered_question
    if self.sibling_responses.exists?(user_id: self.user_id)
      errors[:duplicate] << "already answered question"
    end
  end

  def author_can_not_respond_to_own_poll
    if self.answer_choice.question.poll.author_id == self.user_id
      errors[:cheating] << "cannot answer own poll questions"
    end
  end
end
