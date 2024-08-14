{{/* vim: set filetype=mustache: */}}

{{- define "kyverno.background-controller.name" -}}
{{ template "kyverno.name" . }}-background-controller
{{- end -}}

{{- define "kyverno.background-controller.image" -}}
{{- if .image.registry -}}
  {{ .image.registry }}/{{ required "An image repository is required" .image.repository }}:{{ default .defaultTag .image.tag }}
{{- else -}}
  {{ required "An image repository is required" .image.repository }}:{{ default .defaultTag .image.tag }}
{{- end -}}
{{- end -}}

{{/* Create the name of the service account to use */}}
{{- define "kyverno.background-controller.sAccountName" -}}
{{- if .Values.kyverno.backgroundController.rbac.create -}}
    {{ default (include "kyverno.background-controller.name" .) .Values.kyverno.backgroundController.rbac.saccount.name }}
{{- else -}}
    {{ required "A service account name is required when `rbac.create` is set to `false`" .Values.kyverno.backgroundController.rbac.saccount.name }}
{{- end -}}
{{- end -}}
