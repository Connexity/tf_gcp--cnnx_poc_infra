resource "google_pubsub_topic" "pub-sub_test-terraform-import-topic_topic" {
  name = "test-terraform-import-topic"
  labels = {
    owner = "infrastructure"
    app = "sysops"
  }
}

data "google_iam_policy" "pub-sub_test-terraform-import-topic_topic-iam-roles" {

  binding {
    role = "roles/pubsub.subscriber"
    members = [
      "serviceAccount:sftpaccess@cnnx-poc-infra.iam.gserviceaccount.com"
    ]
  }
  binding {
    role = "roles/pubsub.viewer"
    members = [
      "serviceAccount:sftpaccess@cnnx-poc-infra.iam.gserviceaccount.com",
    ]
  }
  binding {
    role = "roles/pubsub.publisher"
    members = [
      "serviceAccount:sftpaccess@cnnx-poc-infra.iam.gserviceaccount.com"
    ]
  }
}

resource "google_pubsub_topic_iam_policy" "pub-sub_test-terraform-import-topic_topic-iam-policy" {
  project = "${var.gcp_project}"
  topic = google_pubsub_topic.pub-sub_test-terraform-import-topic_topic.name
  policy_data = data.google_iam_policy.pub-sub_test-terraform-import-topic_topic-iam-roles.policy_data
}

resource "google_pubsub_subscription" "pub-sub_test-terraform-import-topic-sub_topic_subscription" {
  name  = "test-terraform-import-topic-sub"
  topic = google_pubsub_topic.pub-sub_test-terraform-import-topic_topic.name
  labels = {
    owner = "infrastructure"
    app = "sysops"
  }
  expiration_policy {
    ttl = ""
  }
}

data "google_iam_policy" "pub-sub_test-terraform-import-topic-sub_topic-subscription-iam-roles" {
  binding {
    role = "roles/pubsub.subscriber"
    members = [
      "serviceAccount:sftpaccess@cnnx-poc-infra.iam.gserviceaccount.com"
    ]
  }
}

resource "google_pubsub_subscription_iam_policy" "pub-sub_test-terraform-import-topic-sub_topic_subscription-policy" {
  project = "${var.gcp_project}"
  subscription = google_pubsub_subscription.pub-sub_test-terraform-import-topic-sub_topic_subscription.name
  policy_data = data.google_iam_policy.pub-sub_test-terraform-import-topic-sub_topic-subscription-iam-roles.policy_data
}
