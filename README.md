The app fetch tweets of ruby  rails topics  and send to kinesis then lambda
function get invokes and save these to database .

The app contains

1. Kinesis stream
2. Lambda Function
3. DynamoDB table

To run try it out
Put twitter api key and credentials in producer/tweets_stream.rb
Then run it normally by `ruby producer/tweets_stream.rb`

To Deploy the app
1. Create bucket ```aws s3 mb s3://tweets-stream```
2. Package your app by running

 ```
sam package --template-file template.yaml \
--output-template-file packaged-template.yaml \
--s3-bucket tweets-stream
```

3. Deploy app

```
sam deploy --template-file packaged-template.yaml --stack-name tweets-stream --capabilities CAPABILITY_IAM
```
Resources: https://aws.amazon.com/de/blogs/compute/announcing-ruby-support-for-aws-lambda/
