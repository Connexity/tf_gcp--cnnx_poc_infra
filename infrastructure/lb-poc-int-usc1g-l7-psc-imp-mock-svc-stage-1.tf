
resource "google_compute_region_health_check" "lb_int_hc_usc1g_l7_psc_imp_mock_svc_stage_1_8080_tf" {
  name     = "lb-int-hc-usc1g-l7-psc-imp-mock-svc-stage-1-8080-tf"
  region   = "us-central1"
  project   = "${var.gcp_project}"
  timeout_sec         = 5
  check_interval_sec  = 5
  healthy_threshold   = 2
  unhealthy_threshold = 2

  tcp_health_check {
    port = "8080"
  }
}

resource "google_compute_region_backend_service" "lb_int_be_usc1g_l7_psc_imp_mock_svc_stage_1_tf" {
  name                  = "lb-int-be-usc1g-l7-psc-imp-mock-svc-stage-1-tf"
  region                = "us-central1"
  project               = "${var.gcp_project}"
  protocol              = "HTTP"
  load_balancing_scheme = "INTERNAL_MANAGED"
  timeout_sec           = 30
  health_checks         = [google_compute_region_health_check.lb_int_hc_usc1g_l7_psc_imp_mock_svc_stage_1_8080_tf.id]
  backend {
    group           = "projects/cnnx-stage-k8s/zones/us-central1-a/networkEndpointGroups/neg-psc-imp-mock-service"
    balancing_mode  = "RATE"
    max_rate        = 1000
    capacity_scaler = 1.0
  }
}
#
#resource "google_compute_region_url_map" "lb_int_um_usc1g_l7_psc_imp_mock_svc_stage_1_tf" {
#  name            = "lb-int-um-usc1g-l7-psc-imp-mock-svc-stage-1-tf"
#  region          = "us-central1"
#  project         = "${var.gcp_project}"
#  default_service = google_compute_region_backend_service.lb_int_be_usc1g_l7_psc_imp_mock_svc_stage_1_tf.id
#}
#
#resource "google_compute_region_target_http_proxy" "lb_int_tp_http_usc1g_l7_psc_imp_mock_svc_stage_1_tf" {
#  name     = "lb-int-tp-http-usc1g-l7-psc-imp-mock-svc-stage-1-tf"
#  region   = "us-central1"
#  project  = "${var.gcp_project}"
#  url_map  = google_compute_region_url_map.lb_int_um_usc1g_l7_psc_imp_mock_svc_stage_1_tf.id
#}
#
#resource "google_compute_forwarding_rule" "lb_int_fr_v4_http_usc1g_l7_psc_imp_mock_svc_stage_1_tf" {
#  name                  = "lb-int-fr-v4-http-usc1g-l7-psc-imp-mock-svc-stage-1-tf"
#  region                = "us-central1"
#  project               = "${var.gcp_project}"
#  depends_on            = []
#  ip_protocol           = "TCP"
#  load_balancing_scheme = "INTERNAL_MANAGED"
#  port_range            = "8080"
#  target                = google_compute_region_target_http_proxy.lb_int_tp_http_usc1g_l7_psc_imp_mock_svc_stage_1_tf.id
#  network               = "projects/cnnx-sandbox-infra/global/networks/default"
#  subnetwork            = "projects/cnnx-sandbox-infra/regions/us-central1/subnetworks/default"
#  network_tier          = "PREMIUM"
#}
#
#resource "google_compute_service_attachment" "psc_int_v4_http_usc1g_l7_imp_mock_svc_stage_1_tf" {
#  name        = "psc-int-v4-http-usc1g-l7-imp-mock-svc-stage-1-tf"
#  region      = "us-central1"
#  description = "imp mock service k8s private service connect service producer attachment endpoint"
#
#  enable_proxy_protocol    = false
#  connection_preference    = "ACCEPT_AUTOMATIC"
#  nat_subnets              = ["projects/cnnx-sandbox-infra/regions/us-central1/subnetworks/lb-psc-nat-usc1g-stage-1"]
#  target_service           = google_compute_forwarding_rule.lb_int_fr_v4_http_usc1g_l7_psc_imp_mock_svc_stage_1_tf.id
#}
#
#
