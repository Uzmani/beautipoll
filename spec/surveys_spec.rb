require 'spec_helper'

describe Survey do 


  subject { FactoryGirl.create(:survey_with_questions) }

  it { should be_valid }

  it { should respond_to(:title)}
  it { should respond_to(:questions)}
  it { should respond_to(:user)}

  describe "with an empty title" do
  it { should respond_to(:completed_surveys)}
    before { subject.title = '' }
    it { should_not be_valid }
  end

  # describe "with no questions" do
  #   before { subject.questions = []}
  #   it { should_not be_valid }
  # end

  describe "without a user" do
    before { subject.user = nil }
    it { p subject.questions; should_not be_valid }
  end

end