{{/* vim: set filetype=mustache: */}}

{{- define "kyverno.pre-upgrade-job.name" -}}
  kyverno-pre-upgrade-job
{{- end -}}

{{/* Create the name of the service account to use */}}
{{- define "kyverno.pre-upgrade-job.sAccountName" -}}
{{- if .Values.kyverno.deleteCrd.rbac.create -}}
    {{ default (include "kyverno.pre-upgrade-job.name" .) .Values.kyverno.deleteCrd.rbac.saccount.name }}
{{- else -}}
    {{ required "A service account name is required when `rbac.create` is set to `false`" .Values.kyverno.deleteCrd.rbac.saccount.name }}
{{- end -}}
{{- end -}}
