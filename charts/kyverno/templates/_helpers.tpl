{{/*
Expand the name of the chart.
*/}}
{{- define "kyverno.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "kyverno.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "kyverno.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/* Helm required labels */}}
{{- define "kyverno.labels" -}}
app.kubernetes.io/component: kyverno
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/name: {{ template "kyverno.name" . }}
app.kubernetes.io/part-of: {{ template "kyverno.name" . }}
app.kubernetes.io/version: "{{ .Chart.Version }}"
helm.sh/chart: {{ include "kyverno.chart" . }}
{{- end -}}

{{/* Get deployed Kyverno version from Kubernetes */}}
{{- define "kyverno.kyvernoVersion" -}}
{{- $version := "" -}}
{{- with (lookup "apps/v1" "Deployment" .Release.Namespace "kyverno") -}}
  {{- with (first .spec.template.spec.containers) -}}
    {{- $imageTag := (split ":" .image)._1 -}}
    {{- $version = trimPrefix "v" $imageTag -}}
  {{- end -}}
{{- end -}}
{{ $version }}
{{- end -}}

{{/* Fail if deployed Kyverno does not match */}}
{{- define "kyverno.supportedKyvernoCheck" -}}
{{- $supportedKyverno := index . "ver" -}}
{{- $top := index . "top" }}
{{- if (include "kyverno.kyvernoVersion" $top) -}}
  {{- if not ( semverCompare $supportedKyverno (include "kyverno.kyvernoVersion" $top) ) -}}
    {{- fail (printf "Kyverno version is too low, expected %s" $supportedKyverno) -}}
  {{- end -}}
{{- end -}}
{{- end -}}
