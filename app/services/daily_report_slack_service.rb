class DailyReportSlackService
  NAME_AND_ICON = {
    username: "Report Bot",
    icon_emoji: ":pepe2:"
  }.freeze

  def initialize channel = ENV["SLACK_WEBHOOK_CHANNEL"]
    @uri = URI(ENV["SLACK_WEBHOOK_URL"])
    @channel = channel
  end

  def create_report
    @current_user_count   = User.all.count
    @new_user_count       = User.new_users.count
    @new_post_count       = Micropost.new_posts.count
    @new_post             = Micropost.new_posts
    @new_react = ReactPost.new_reactposts
    @new_reply = Reply.new_replies
    @new_chat = Message.new_chats
    @user_interact_count = @new_post.pluck(:user_id) + @new_react.pluck(:user_id) + @new_reply.pluck(:user_id) + @new_chat.pluck(:user_id)
    @user_interact_count = @user_interact_count.uniq.count
    daily_report(@current_user_count, @new_user_count, @new_post_count, @user_interact_count).deliver
  rescue StandardError => e
    error_report("Exception at #{__method__} " + e.message).deliver
  end

  def daily_report user_count, new_user_count, new_post_count, interactive_user
    params = {
      attachments: [
        {
          title: "Daily report",
          fallback: "Daily report",
          color: "Good",
          fields: [
            {
              title: "Current User Count",
              value: user_count,
              short: true
            },
            {
              title: "New User Count",
              value: new_user_count,
              short: true
            },
            {
              title: "New Post Count",
              value: new_post_count,
              short: true
            },
            {
              title: "Unique User Activity",
              value: interactive_user,
              short: true
            },
            {
              value: "<@U030WH7HR8U>, <@U03079JHZ47>"
            }
          ]
        }
      ]
    }
    @params = generate_payload(params)
    self
  end

  def error_report(message)
    params = {
      attachments: [
        {
          title: "Error report",
          fallback: "Error report",
          fields: [
            {
              value: message
            },
            {
              value: "<@U03079JHZ47>, <@U03079JHZ47>"
            }
          ]
        }
      ]
    }
    @params = generate_payload(params)
    self
  end

  def deliver
    response = Net::HTTP.post_form(@uri, @params)
    raise "Error code #{response.code}" if response.code != "200"
  rescue StandardError => e
    Rails.logger.error("DailyReportSlackService: Error when sending: #{e.message}")
  end

  def generate_payload(params)
    {
      payload: NAME_AND_ICON
        .merge(channel: @channel)
        .merge(params).to_json
    }
  end
end
