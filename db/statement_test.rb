# Test case to ensure statement coverage for User model
describe User do
    it "creates a new user" do
      user = User.new(email: "test@example.com", password: "password")
      expect(user.save).to be true
    end
  end