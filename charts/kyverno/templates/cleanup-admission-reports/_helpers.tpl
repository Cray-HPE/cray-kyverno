{{/* vim: set filetype=mustache: */}}

{{- define "kyverno.cleanup-admission-reports.name" -}}
{{ template "kyverno.name" . }}-cleanup-admission-reports
{{- end -}}

{{- define "kyverno.cleanup-admission-reports.image" -}}
{{- if .image.registry -}}
  {{ .image.registry }}/{{ required "An image repository is required" .image.repository }}:{{ default .defaultTag .image.tag }}
{{- else -}}
  {{ required "An image repository is required" .image.repository }}:{{ default .defaultTag .image.tag }}
{{- end -}}
{{- end -}}

{{/* Create the name of the service account to use */}}
{{- define "kyverno.cleanup-admission-reports.sAccountName" -}}
{{- if .Values.kyverno.cleanupJobs.admissionReports.rbac.create -}}
    {{ default (include "kyverno.cleanup-admission-reports.name" .) .Values.kyverno.cleanupJobs.admissionReports.rbac.saccount.name }}
{{- else -}}
    {{ required "A service account name is required when `rbac.create` is set to `false`" .Values.kyverno.cleanupJobs.admissionReports.rbac.saccount.name }}
{{- end -}}
{{- end -}}
