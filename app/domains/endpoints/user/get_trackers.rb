module Endpoints
  module Trackers
    class GetTrackers < BaseClient
      TRACKER_ENDPOINT = "tracker/".freeze
      TRACKER_ID = ENV["TRACTIVE_TRACKER_ID"].freeze

      Response = Struct.new(:success, :status, :body)
