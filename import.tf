import {
  id = "projects/cnnx-poc-infra/topics/test-terraform-import-topic"
  to = module.infrastructure.google_pubsub_topic.pub-sub_test-terraform-import-topic_topic
}

import {
  id = "projects/cnnx-poc-infra/subscriptions/test-terraform-import-topic-sub"
  to = module.infrastructure.google_pubsub_subscription.pub-sub_test-terraform-import-topic-sub_topic_subscription
}
