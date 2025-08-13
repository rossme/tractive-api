module Endpoints
  module User
    class GetTracker < BaseClient
      TRACKERS_ENDPOINT = "tracker/".freeze

      Response = Struct.new(:success, :status, :body)

      class << self
        def get_tracker(tracker_id:)
          tracker_response = client.get(TRACKERS_ENDPOINT + tracker_id) do |req|
            req.headers["Authorization"] = "Bearer #{auth_token}"
          end

          Response.new(success: true, status: tracker_response.status, body: tracker_response.body)
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
