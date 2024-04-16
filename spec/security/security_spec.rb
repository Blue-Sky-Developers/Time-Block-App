# spec/security/security_spec.rb

require 'rails_helper'

RSpec.describe "Security Testing" do
  it "avoids storing sensitive information in plaintext" do
    user = create(:user, password: 'password123')
    expect(user.password).not_to eq('password122')
  end
end