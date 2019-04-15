require 'securerandom'
require "twitter"
require "aws-sdk-kinesis"

class TweetsStream
  def initialize(topics=["rails", "ruby"])
    @topics = topics
  end

  def fetch_tweets
    twitter_client.filter(track: @topics.join(",")) do |object|
       resp = aws_client.put_record(
         {
           stream_name: "tweets-stream-TweetsStream-DBI9JYZVM2NK",
           data: object.text,
           partition_key: SecureRandom.random_number.to_s
         })
       puts object.text if object.is_a?(Twitter::Tweet)
      puts resp
    end
  end

  private

  def twitter_client
    @twitter_client ||= Twitter::Streaming::Client.new do |config|
      config.consumer_key        = ENV["CONSUMER_KEY"]
      config.consumer_secret     = ENV["CONSUMER_SECRET"]
      config.access_token        = ENV["ACCESS_TOKEN"]
      config.access_token_secret = ENV["ACCESS_TOKEN_SECRET"]
    end
  end

  def aws_client
    @aws_client ||= Aws::Kinesis::Client.new
  end
end

TweetsStream.new.fetch_tweets
