resource "google_dataproc_job" "dataproc-hadoop-test" {
  region       = "us-central1"
  force_delete = true
  placement {
    cluster_name = "dataproc-test-cluster-gce"
  }
 
  hadoop_config {
    main_jar_file_uri = "file:///usr/lib/hadoop-mapreduce/hadoop-mapreduce-examples.jar"
    args = [
      "wordcount",
      "gs://dataproc-test-bucket_cnnx-poc-infra/Test.txt",
      "gs://${google_dataproc_cluster.dataproc_cluster-dataproc-test-cluster-gce.cluster_config[0].bucket}/hadoopjob_output",
    ]
  }
}
