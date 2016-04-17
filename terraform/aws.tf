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

resource "aws_cloudwatch_metric_alarm" "sqs-queue-count" {
  alarm_name = "sqs-queue-count"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods = "1"
  metric_name = "ApproximateNumberOfMessagesVisible"
  namespace = "AWS/SQS"
  period = "600" // seconds
  statistic = "Average"
  threshold = "1"
  dimensions {
    QueueName = "${aws_sqs_queue.sqs-sns-lambda-test-queue.name}"
  }
  alarm_description = "Fire alarm if SQS queue count >= 1"
  alarm_actions = [
    "${aws_sns_topic.sns-queue-topic.arn}"
  ]
}

resource "aws_sns_topic" "sns-queue-topic" {
  name = "sqs-sns-lambda-test-sns"
}
