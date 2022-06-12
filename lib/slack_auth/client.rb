# frozen_string_literal: true

module SlackAuth
  class Client
    class << self
      def authorize(request)
        response = SlackAuth::Api.oauth_v2_access(code: request.query_parameters[:code])
        profile = {}

        if response.code == "200"
          json_body = JSON.parse(response.body, symbolize_names: true)

          if json_body.key?(:authed_user)
            profile_response = SlackAuth::Api.openid_connect_userinfo(token: json_body.dig(:authed_user, :access_token))

            if profile_response.code == "200"
              profile = JSON.parse(profile_response.body, symbolize_names: true)
            end
          end
        end

        user = {
          profile: profile,
          authed_user: json_body.fetch(:authed_user, nil),
        }

        yield(user, response) if block_given?

        user
      end
    end
  end
end
