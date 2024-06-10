resource "google_logging_project_exclusion" "logging_project_exclusion_data_proc_exclusion_pig_warning" {
  name = "data_proc_exclusion_pig_warning"

  description = "data_proc_exclusion_pig_warning"

  # Exclude all 
  filter = <<EOF
    resource.type="cloud_dataproc_cluster" 
    AND 
    jsonPayload.class = "org.apache.pig.backend.hadoop.executionengine.mapReduceLayer.PigHadoopLogger" 
    AND 
    (severity = "WARNING" OR severity = "INFO" OR severity = "DEBUG")
  EOF
}
