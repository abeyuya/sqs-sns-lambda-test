resource "aws_sqs_queue" "sqs-sns-lambda-test-queue" {
  name = "sqs-sns-lambda-test-queue"
  delay_seconds = 0
  max_message_size = 2048
  message_retention_seconds = 86400
  receive_wait_time_seconds = 10
  /*redrive_policy = <<EOF
{
  "deadLetterTargetArn": "${aws_sqs_queue.terraform_queue_deadletter.arn}",
  "maxReceiveCount": 4
}
EOF*/
}
