require 'rails_helper'

RSpec.describe User, type: :model do
  context 'create user' do
    it 'creates a user with valid attributes' do
      user = User.new(
        name: 'REX'
      )
      expect(user).to be_valid
    end
  end
end
