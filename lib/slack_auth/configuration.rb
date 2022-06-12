# frozen_string_literal: true

module SlackAuth
  class Configuration
    attr_accessor :client_id, :client_secret

    def initialize
      @client_id = ENV["SLACK_CLIENT_ID"]
      @client_secret = ENV["SLACK_CLIENT_SECRET"]
    end
  end
end
