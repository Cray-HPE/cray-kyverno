{{/* vim: set filetype=mustache: */}}

{{- define "kyverno.cleanup-cluster-admission-reports.name" -}}
{{ template "kyverno.name" . }}-cleanup-cluster-admission-reports
{{- end -}}

{{- define "kyverno.cleanup-cluster-admission-reports.image" -}}
{{- if .image.registry -}}
  {{ .image.registry }}/{{ required "An image repository is required" .image.repository }}:{{ default .defaultTag .image.tag }}
{{- else -}}
  {{ required "An image repository is required" .image.repository }}:{{ default .defaultTag .image.tag }}
{{- end -}}
{{- end -}}

{{/* Create the name of the service account to use */}}
{{- define "kyverno.cleanup-cluster-admission-reports.sAccountName" -}}
{{- if .Values.kyverno.cleanupJobs.clusterAdmissionReports.rbac.create -}}
    {{ default (include "kyverno.cleanup-cluster-admission-reports.name" .) .Values.kyverno.cleanupJobs.clusterAdmissionReports.rbac.saccount.name }}
{{- else -}}
    {{ required "A service account name is required when `rbac.create` is set to `false`" .Values.kyverno.cleanupJobs.clusterAdmissionReports.rbac.saccount.name }}
{{- end -}}
{{- end -}}
