# Test case to ensure condition coverage for Event model
describe Event do
    context "with valid start and end times" do
      it "creates a new event" do
        user = User.create(email: "test@example.com", password: "password")
        event = Event.new(name: "Test Event", start_time: Time.now, end_time: Time.now + 1.hour, user_id: user.id)
        expect(event.save).to be true
      end
    end
  
    context "with end time before start time" do
      it "does not create a new event" do
        user = User.create(email: "test@example.com", password: "password")
        event = Event.new(name: "Test Event", start_time: Time.now, end_time: Time.now - 1.hour, user_id: user.id)
        expect(event.save).to be false
      end
    end
  end