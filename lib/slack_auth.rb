# frozen_string_literal: true

require "net/http"
require "jwt"

require "slack_auth/api"
require "slack_auth/client"
require "slack_auth/configuration"
require "slack_auth/version"

module SlackAuth
  class << self
    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield(configuration)
    end
  end
end
