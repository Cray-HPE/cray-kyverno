{{/* vim: set filetype=mustache: */}}

{{- define "kyverno.reports-controller.name" -}}
{{ template "kyverno.name" . }}-reports-controller
{{- end -}}

{{- define "kyverno.reports-controller.image" -}}
{{- if .image.registry -}}
  {{ .image.registry }}/{{ required "An image repository is required" .image.repository }}:{{ default .defaultTag .image.tag }}
{{- else -}}
  {{ required "An image repository is required" .image.repository }}:{{ default .defaultTag .image.tag }}
{{- end -}}
{{- end -}}

{{/* Create the name of the service account to use */}}
{{- define "kyverno.reports-controller.sAccountName" -}}
{{- if .Values.kyverno.reportsController.rbac.create -}}
    {{ default (include "kyverno.reports-controller.name" .) .Values.kyverno.reportsController.rbac.saccount.name }}
{{- else -}}
    {{ required "A service account name is required when `rbac.create` is set to `false`" .Values.kyverno.reportsController.rbac.saccount.name }}
{{- end -}}
{{- end -}}
