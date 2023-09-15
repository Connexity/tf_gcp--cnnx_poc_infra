resource "google_compute_service_attachment" "psc_int_v4_http_usc1g_l7_usc1g_stage_k8s_1_pricing_config_svc_1_tf" {
  name        = "psc-int-v4-http-usc1g-l7-usc1g-stage-k8s-1-pricing-config-svc-1-tf"
  region      = "us-central1"
  description = "Pricing Config Service staging gcp staging k8s-1 private service connect service producer attachment endpoint"

  enable_proxy_protocol    = false
  connection_preference    = "ACCEPT_AUTOMATIC"
  nat_subnets              = ["projects/cnnx-infra-networking/regions/us-central1/subnetworks/cnnx-infra-networking-core-vpc-usc1g-prv-srvc-connect-1"]
  target_service           = "projects/cnnx-stage-k8s/regions/us-central1/forwardingRules/k8s2-fr-jil79ggd-invent-imp-mock-service-psc-internal--ou11nevh"
}
