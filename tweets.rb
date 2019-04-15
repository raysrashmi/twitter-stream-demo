require "aws-record"
require "aws-sdk-kinesis"
require 'base64'

class TweetsModel
  include Aws::Record
  set_table_name ENV['DDB_TABLE']
  string_attr :id, hash_key: true
  string_attr :body
end

def parse_and_save(event:, context:)
  event["Records"].each do |record|
    body = record["kinesis"]["data"]
    data = Base64.decode64(body)
    item = TweetsModel.new(id: SecureRandom.uuid, body: data)
    item.save! # raise an exception if save fails
    item.to_h
  end
end
