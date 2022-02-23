require "rails_helper"

RSpec.describe ReportMailer, type: :mailer do
  describe "block_notification" do
    let(:mail) { ReportMailer.block_notification }

    it "renders the headers" do
      expect(mail.subject).to eq("Block notification")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
