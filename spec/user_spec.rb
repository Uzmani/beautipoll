require 'spec_helper'

describe User do
  
  before do 
    @user = User.new
  end

  subject { @user }

  it { should respond_to(:name)}
  it { should respond_to(:password_hash)}
  it { should respond_to(:email)}

end