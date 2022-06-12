# frozen_string_literal: true

module SlackAuth
  class Client
    class << self
      def authorize(request)
        response = SlackAuth::Api.openid_connect_token(code: request.query_parameters[:code])
        json_body = {}

        if response.code == "200"
          json_body = JSON.parse(response.body)

          if json_body.key?("id_token")
            profile = JWT.decode(json_body["id_token"], nil, false).first
          end
        end

        user = {
          access_token: json_body["access_token"],
          profile: profile,
        }

        yield(user, response) if block_given?

        user
      end
    end
  end
end
