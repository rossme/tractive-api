module Endpoints
  module User
    class UpdateUser < BaseClient
      USER_ENDPOINT = "user/".freeze
      USER_ID = ENV["TRACTIVE_USER_ID"].freeze
      TRACTIVE_GRAPH_VERSION = ENV["TRACTIVE_GRAPH_VERSION"].freeze

      Response = Struct.new(:success, :status, :body)

      class << self
        def put_user(params = {})
          user_response = client.put(USER_ENDPOINT + USER_ID) do |req|
            req.headers["Authorization"] = "Bearer #{auth_token}"
            req.body = merged_params(params)
          end

          Response.new(success: true, status: user_response.status, body: user_response.body)
        rescue Faraday::Error => e
          Response.new(success: false, status: e.response[:status])
        end

        def auth_token
          @auth_token ||= Endpoints::Authentication::AuthToken.get_access_token
        end

        def merged_params(params)
          {
            _version: TRACTIVE_GRAPH_VERSION
          }.merge!(params)
        end
      end
    end
  end
end
