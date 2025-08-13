module Endpoints
  module User
    class GetTrackers < BaseClient
      USER_ENDPOINT = "user/".freeze
      USER_ID = ENV["TRACTIVE_USER_ID"].freeze
      TRACKERS_ENDPOINT = "#{USER_ENDPOINT + USER_ID}/trackers".freeze

      Response = Struct.new(:success, :status, :body)

      class << self
        def get_trackers
          trackers_response = client.get(TRACKERS_ENDPOINT) do |req|
            req.headers["Authorization"] = "Bearer #{auth_token}"
          end

          Response.new(success: true, status: trackers_response.status, body: trackers_response.body)
        rescue Faraday::Error => e
          Response.new(success: false, status: e.response[:status])
        end

        def auth_token
          @auth_token ||= Endpoints::Authentication::AuthToken.get_access_token
        end
      end
    end
  end
end
