require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  describe 'welcome email' do
    let(:user) { create(:user) }
    let(:mail) { UserMailer.with(user:user).welcome_email }

    it 'renders the headers' do
      expect(mail.subject).to eq('Welcome to Lunch and Learn!')
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(["LandLnotifs@gmail.com"])
    end

    it 'renders the body' do
      expect(mail.body.include?('Thanks for joining and have a great day!')).to eq(true)
    end
  end
end