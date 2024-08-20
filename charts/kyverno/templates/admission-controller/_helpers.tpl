{{/* vim: set filetype=mustache: */}}

{{- define "kyverno.admission-controller.name" -}}
{{ template "kyverno.name" . }}-admission-controller
{{- end -}}

{{- define "kyverno.admission-controller.image" -}}
{{- if .image.registry -}}
  {{ .image.registry }}/{{ required "An image repository is required" .image.repository }}:{{ default .defaultTag .image.tag }}
{{- else -}}
  {{ required "An image repository is required" .image.repository }}:{{ default .defaultTag .image.tag }}
{{- end -}}
{{- end -}}

{{/* Create the name of the service account to use */}}
{{- define "kyverno.admission-controller.sAccountName" -}}
{{- if .Values.kyverno.admissionController.rbac.create -}}
    {{ default (include "kyverno.admission-controller.name" .) .Values.kyverno.admissionController.rbac.saccount.name }}
{{- else -}}
    {{ required "A service account name is required when `rbac.create` is set to `false`" .Values.kyverno.admissionController.rbac.saccount.name }}
{{- end -}}
{{- end -}}
