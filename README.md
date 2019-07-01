The app fetch tweets of ruby  rails topics  and send to kinesis then lambda
function get invokes and save these to database .

The app contains

1. Kinesis stream
2. Lambda Function
3. DynamoDB table

To run try it out
Put twitter api key and credentials in producer/tweets_stream.rb
Then run it normally by `ruby producer/tweets_stream.rb`

To Push this code to amazon follow the steps mention here https://aws.amazon.com/de/blogs/compute/announcing-ruby-support-for-aws-lambda/
