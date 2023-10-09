{{/* vim: set filetype=mustache: */}}

{{- define "kyverno.cleanup-controller.name" -}}
{{ template "kyverno.name" . }}-cleanup-controller
{{- end -}}

{{- define "kyverno.cleanup-controller.labels" -}}
app.kubernetes.io/part-of: {{ template "kyverno.name" . }}
{{- with (include "kyverno.helmLabels" .) }}
{{ . }}
{{- end }}
{{- with (include "kyverno.versionLabels" .) }}
{{ . }}
{{- end }}
{{- with (include "kyverno.cleanup-controller.matchLabels" .) }}
{{ . }}
{{- end }}
{{- end -}}

{{- define "kyverno.cleanup-controller.matchLabels" -}}
app.kubernetes.io/component: cleanup-controller
app.kubernetes.io/name: {{ template "kyverno.cleanup-controller.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{- define "kyverno.cleanup-controller.image" -}}
{{- if .image.registry -}}
  {{ .image.registry }}/{{ required "An image repository is required" .image.repository }}:{{ default .defaultTag .image.tag }}
{{- else -}}
  {{ required "An image repository is required" .image.repository }}:{{ default .defaultTag .image.tag }}
{{- end -}}
{{- end -}}

{{/* Create the name of the service account to use */}}
{{- define "kyverno.cleanup-controller.sAccountName" -}}
{{- if .Values.kyverno.cleanupController.rbac.create -}}
    {{ default (include "kyverno.cleanup-controller.name" .) .Values.kyverno.cleanupController.rbac.saccount.name }}
{{- else -}}
    {{ required "A service account name is required when `rbac.create` is set to `false`" .Values.kyverno.cleanupController.rbac.saccount.name }}
{{- end -}}
{{- end -}}
