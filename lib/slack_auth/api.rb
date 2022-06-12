# frozen_string_literal: true

module SlackAuth
  class Api

    BASE_URL = "https://slack.com/api"

    class << self
      def openid_connect_token(code:)
        Net::HTTP.post_form(
          uri("openid.connect.token"),
          {
            code: code,
            client_secret: SlackAuth.configuration.client_secret,
            client_id: SlackAuth.configuration.client_id,
          },
        )
      end

      private

      def uri(endpoint)
        URI("#{BASE_URL}/#{endpoint}")
      end
    end
  end
end
