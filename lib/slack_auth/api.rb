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

      def oauth_v2_access(code:)
        Net::HTTP.post_form(
          uri("oauth.v2.access"),
          {
            code: code,
            client_secret: SlackAuth.configuration.client_secret,
            client_id: SlackAuth.configuration.client_id,
          },
        )
      end

      def openid_connect_userinfo(token:)
        Net::HTTP.post_form(
          uri("openid.connect.userInfo"), { token: token }
        )
      end

      private

      def uri(endpoint)
        URI("#{BASE_URL}/#{endpoint}")
      end
    end
  end
end
