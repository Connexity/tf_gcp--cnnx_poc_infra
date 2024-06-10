resource "google_logging_project_exclusion" "logging_project_exclusion_data_proc_exclusion_pig_warning" {
  name = "data_proc_exclusion_pig_warning"

  description = "data_proc_exclusion_pig_warning"

  # Exclude all pig logging Warn and below
  filter = <<EOF
    resource.type="cloud_dataproc_cluster" 
    AND 
    jsonPayload.class = "org.apache.pig.backend.hadoop.executionengine.mapReduceLayer.PigHadoopLogger" 
    AND 
    (severity = "WARNING" OR severity = "INFO" OR severity = "DEBUG")
  EOF
}

resource "google_logging_project_exclusion" "logging_project_exclusion_data_proc_exclusion_default" {
  name = "data_proc_exclusion_default"

  description = "data_proc_exclusion_default"

  # Exclude all datproc logging Info and below
  filter = <<EOF
    resource.type="cloud_dataproc_cluster"
    AND
    severity != "EMERGENCY"
    AND
    severity != "ALERT"
    AND
    severity != "CRITICAL"
    AND
    severity != "ERROR"
    AND
    severity != "WARNING"
  EOF
}
