require 'rails_helper'

RSpec.describe DailyReportJob, type: :job do
  it "should handle response failure" do
    @uri = URI(ENV["SLACK_WEBHOOK_URL"])
    params = {
      attachments: [
        {
          title: "Daily report",
          fallback: "Daily report",
          color: "Good",
          fields: [
            {
              title: "Current User Count",
              value: 1,
              short: true
            },
            {
              title: "New User Count",
              value: 2,
              short: true
            },
            {
              title: "New Post Count",
              value: 3,
              short: true
            },
            {
              title: "Unique User Activity",
              value: 4,
              short: true
            },
            {
              value: "<@U03079JHZ47>, <@U03079JHZ47>"
            }
          ]
        }
      ]
    }
    @params = DailyReportSlackService.new.generate_payload(params)
    VCR.use_cassette "send message", record: :all do
      response = Net::HTTP.post_form(@uri, @params)
      raise "Error code #{response.code}" if response.code != "200"
    end
  end
end
