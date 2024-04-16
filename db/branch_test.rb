# Test case to ensure branch coverage for User model email validation
describe User do
    context "with valid email" do
      it "creates a new user" do
        user = User.new(email: "test@example.com", password: "password")
        expect(user.save).to be true
      end
    end
  
    context "with invalid email" do
      it "does not create a new user" do
        user = User.new(email: "invalid_email", password: "password")
        expect(user.save).to be false
      end
    end
  end