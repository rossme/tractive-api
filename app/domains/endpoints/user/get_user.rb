module Endpoints
  module User
    class Get < BaseClient
      USER_ENDPOINT = "user/".freeze
      USER_ID = ENV["TRACTIVE_USER_ID"]

      Response = Struct.new(:success, :status, :body)

      class << self
        def get_user
          user_response = client.get(USER_ENDPOINT + USER_ID) do |req|
            req.headers["Authorization"] = "Bearer #{auth_token}"
          end

          Response.new(success: true, status: user_response.status, body: user_response.body)
        rescue StandardError => e
          Response.new(success: false, status: e.response[:status])
        end

        def auth_token
          @auth_token ||= Endpoints::Authentication::AuthToken.get_access_token
        end
      end
    end
  end
end
