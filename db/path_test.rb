test 'event end_time should be after start_time' do
    user = User.create(email: 'test@example.com', password: 'password123')
    event = user.events.build(name: 'Test Event', start_time: Time.now, end_time: Time.now - 1.hour)
    assert_not event.valid?, 'Event should not be valid with end_time before start_time'
  end
  