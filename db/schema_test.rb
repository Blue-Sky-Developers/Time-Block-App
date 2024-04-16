# test/models/event_test.rb
require 'test_helper'

class EventTest < ActiveSupport::TestCase
  setup do
    @user = User.create!(email: 'test@example.com', password_digest: 'password')
    @event = @user.events.build(name: 'Sample Event', start_time: DateTime.current, end_time: DateTime.current + 1.hour)
  end

  test 'event should be valid' do
    assert @event.valid?
  end

  test 'should require a user association' do
    @event.user = nil
    assert_not @event.valid?
  end

  test 'start time should be before end time' do
    @event.start_time = DateTime.current + 1.hour
    @event.end_time = DateTime.current
    assert_not @event.valid?
  end
end

# test/models/user_test.rb
require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @user = User.new(email: 'test@example.com', password_digest: 'password')
  end

  test 'user should be valid' do
    assert @user.valid?
  end

  test 'email should be present' do
    @user.email = nil
    assert_not @user.valid?
  end

  test 'email should be unique' do
    duplicate_user = @user.dup
    @user.save!
    assert_not duplicate_user.valid?
  end

  test 'password digest should be present' do
    @user.password_digest = nil
    assert_not @user.valid?
  end
end
