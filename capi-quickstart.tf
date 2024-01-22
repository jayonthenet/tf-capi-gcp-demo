resource "kubernetes_manifest" "cluster_capi_quickstart" {
  manifest = {
    "apiVersion" = "cluster.x-k8s.io/v1beta1"
    "kind" = "Cluster"
    "metadata" = {
      "name" = "capi-quickstart"
      "namespace" = "default"
    }
    "spec" = {
      "clusterNetwork" = {
        "pods" = {
          "cidrBlocks" = [
            "192.168.0.0/16",
          ]
        }
      }
      "controlPlaneRef" = {
        "apiVersion" = "controlplane.cluster.x-k8s.io/v1beta1"
        "kind" = "KubeadmControlPlane"
        "name" = "capi-quickstart-control-plane"
      }
      "infrastructureRef" = {
        "apiVersion" = "infrastructure.cluster.x-k8s.io/v1beta1"
        "kind" = "GCPCluster"
        "name" = "capi-quickstart"
      }
    }
  }
}

resource "kubernetes_manifest" "gcpcluster_capi_quickstart" {
  manifest = {
    "apiVersion" = "infrastructure.cluster.x-k8s.io/v1beta1"
    "kind" = "GCPCluster"
    "metadata" = {
      "name" = "capi-quickstart"
      "namespace" = "default"
    }
    "spec" = {
      "network" = {
        "name" = "default"
      }
      "project" = "clemens-juette-gcp"
      "region" = "europe-west3"
    }
  }
}

resource "kubernetes_manifest" "kubeadmcontrolplane_capi_quickstart_control_plane" {
  manifest = {
    "apiVersion" = "controlplane.cluster.x-k8s.io/v1beta1"
    "kind" = "KubeadmControlPlane"
    "metadata" = {
      "name" = "capi-quickstart-control-plane"
      "namespace" = "default"
    }
    "spec" = {
      "kubeadmConfigSpec" = {
        "clusterConfiguration" = {
          "apiServer" = {
            "extraArgs" = {
              "cloud-provider" = "gce"
            }
            "timeoutForControlPlane" = "20m"
          }
          "controllerManager" = {
            "extraArgs" = {
              "allocate-node-cidrs" = "false"
              "cloud-provider" = "gce"
            }
          }
        }
        "initConfiguration" = {
          "nodeRegistration" = {
            "kubeletExtraArgs" = {
              "cloud-provider" = "gce"
            }
            "name" = "{{ ds.meta_data.local_hostname.split(\".\")[0] }}"
          }
        }
        "joinConfiguration" = {
          "nodeRegistration" = {
            "kubeletExtraArgs" = {
              "cloud-provider" = "gce"
            }
            "name" = "{{ ds.meta_data.local_hostname.split(\".\")[0] }}"
          }
        }
      }
      "machineTemplate" = {
        "infrastructureRef" = {
          "apiVersion" = "infrastructure.cluster.x-k8s.io/v1beta1"
          "kind" = "GCPMachineTemplate"
          "name" = "capi-quickstart-control-plane"
        }
      }
      "replicas" = 3
      "version" = "v1.26.7"
    }
  }
  computed_fields = ["spec.kubeadmConfigSpec.clusterConfiguration.apiServer.timeoutForControlPlane"]
}

resource "kubernetes_manifest" "gcpmachinetemplate_capi_quickstart_control_plane" {
  manifest = {
    "apiVersion" = "infrastructure.cluster.x-k8s.io/v1beta1"
    "kind" = "GCPMachineTemplate"
    "metadata" = {
      "name" = "capi-quickstart-control-plane"
      "namespace" = "default"
    }
    "spec" = {
      "template" = {
        "spec" = {
          "image" = "projects/clemens-juette-gcp/global/images/cluster-api-ubuntu-2204-v1-26-7-1705650560"
          "instanceType" = "n1-standard-2"
        }
      }
    }
  }
}

resource "kubernetes_manifest" "machinedeployment_capi_quickstart_md_0" {
  manifest = {
    "apiVersion" = "cluster.x-k8s.io/v1beta1"
    "kind" = "MachineDeployment"
    "metadata" = {
      "name" = "capi-quickstart-md-0"
      "namespace" = "default"
    }
    "spec" = {
      "clusterName" = "capi-quickstart"
      "replicas" = 3
      "selector" = {
        "matchLabels" = null
      }
      "template" = {
        "spec" = {
          "bootstrap" = {
            "configRef" = {
              "apiVersion" = "bootstrap.cluster.x-k8s.io/v1beta1"
              "kind" = "KubeadmConfigTemplate"
              "name" = "capi-quickstart-md-0"
            }
          }
          "clusterName" = "capi-quickstart"
          "infrastructureRef" = {
            "apiVersion" = "infrastructure.cluster.x-k8s.io/v1beta1"
            "kind" = "GCPMachineTemplate"
            "name" = "capi-quickstart-md-0"
          }
          "version" = "v1.26.7"
        }
      }
    }
  }
}

resource "kubernetes_manifest" "gcpmachinetemplate_capi_quickstart_md_0" {
  manifest = {
    "apiVersion" = "infrastructure.cluster.x-k8s.io/v1beta1"
    "kind" = "GCPMachineTemplate"
    "metadata" = {
      "name" = "capi-quickstart-md-0"
      "namespace" = "default"
    }
    "spec" = {
      "template" = {
        "spec" = {
          "image" = "projects/clemens-juette-gcp/global/images/cluster-api-ubuntu-2204-v1-26-7-1705650560"
          "instanceType" = "n1-standard-2"
        }
      }
    }
  }
}

resource "kubernetes_manifest" "kubeadmconfigtemplate_capi_quickstart_md_0" {
  manifest = {
    "apiVersion" = "bootstrap.cluster.x-k8s.io/v1beta1"
    "kind" = "KubeadmConfigTemplate"
    "metadata" = {
      "name" = "capi-quickstart-md-0"
      "namespace" = "default"
    }
    "spec" = {
      "template" = {
        "spec" = {
          "joinConfiguration" = {
            "nodeRegistration" = {
              "kubeletExtraArgs" = {
                "cloud-provider" = "gce"
              }
              "name" = "{{ ds.meta_data.local_hostname.split(\".\")[0] }}"
            }
          }
        }
      }
    }
  }
}
