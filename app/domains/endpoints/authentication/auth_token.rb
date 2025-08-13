module Authentication
  class AuthToken < BaseClient
    ENDPOINT = "auth/token".freeze

    class << self
      def authenticate
        response = client.post(ENDPOINT) do |req|
          req.body = body_content
        end

        response.body
      rescue Faraday::Error => e
        raise StandardError, "An error occurred while fetching the auth token: #{e.message}"
      end

      def body_content
        {
          grant_type: ENV["TRACTIVE_CLIENT_GRANT_TYPE"],
          platform_email: ENV["TRACTIVE_USER_EMAIL"],
          platform_token: ENV["TRACTIVE_USER_PASSWORD"]
        }
      end
    end
  end
end
