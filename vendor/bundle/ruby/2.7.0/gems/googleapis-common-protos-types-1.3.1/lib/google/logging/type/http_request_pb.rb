# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: google/logging/type/http_request.proto

require 'google/protobuf/duration_pb'
require 'google/protobuf'

Google::Protobuf::DescriptorPool.generated_pool.build do
  add_file("google/logging/type/http_request.proto", :syntax => :proto3) do
    add_message "google.logging.type.HttpRequest" do
      optional :request_method, :string, 1
      optional :request_url, :string, 2
      optional :request_size, :int64, 3
      optional :status, :int32, 4
      optional :response_size, :int64, 5
      optional :user_agent, :string, 6
      optional :remote_ip, :string, 7
      optional :server_ip, :string, 13
      optional :referer, :string, 8
      optional :latency, :message, 14, "google.protobuf.Duration"
      optional :cache_lookup, :bool, 11
      optional :cache_hit, :bool, 9
      optional :cache_validated_with_origin_server, :bool, 10
      optional :cache_fill_bytes, :int64, 12
      optional :protocol, :string, 15
    end
  end
end

module Google
  module Cloud
    module Logging
      module Type
        HttpRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.logging.type.HttpRequest").msgclass
      end
    end
  end
end

module Google
  module Logging
    module Type
      HttpRequest = ::Google::Cloud::Logging::Type::HttpRequest
    end
  end
end