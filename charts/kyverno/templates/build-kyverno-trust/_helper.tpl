{{/* vim: set filetype=mustache: */}}

{{- define "kyverno.post-install-job.name" -}}
  kyverno-post-install-job
{{- end -}}

{{/* Create the name of the service account to use */}}
{{- define "kyverno.post-install-job.sAccountName" -}}
{{- if .Values.kyverno.buildKyvernoTrust.rbac.create -}}
    {{ default (include "kyverno.post-install-job.name" .) .Values.kyverno.buildKyvernoTrust.rbac.saccount.name }}
{{- else -}}
    {{ required "A service account name is required when `rbac.create` is set to `false`" .Values.kyverno.buildKyvernoTrust.rbac.saccount.name }}
{{- end -}}
{{- end -}}
