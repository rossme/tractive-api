# frozen_string_literal: true

class BaseClient
  class << self
    TRACTIVE_BASE_URL = ENV["TRACTIVE_BASE_URL"].freeze
    TRACTIVE_CLIENT_ID = ENV["TRACTIVE_CLIENT_ID"].freeze

    def client
      @_client ||= Faraday.new(url: TRACTIVE_BASE_URL, headers: headers) do |conn|
        conn.request :json
        conn.response :raise_error
        conn.response :json, content_type: /\bjson$/
        conn.adapter Faraday.default_adapter
      end
    end

    private

    def headers
      {
        "Accept" => "application/json",
        "x-tractive-client" => TRACTIVE_CLIENT_ID
      }
    end
  end
end
