{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "faucet.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "faucet.fullname" -}}
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
{{- define "faucet.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "faucet.labels" -}}
helm.sh/chart: {{ include "faucet.chart" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- with .Values.extraLabels }}
{{ toYaml . }}
{{- end }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "faucet.botLabels" -}}
{{ include "faucet.labels" . }}
{{ include "faucet.botSelectorLabels" . }}
{{- end -}}
{{- define "faucet.serverLabels" -}}
{{ include "faucet.labels" . }}
{{ include "faucet.serverSelectorLabels" . }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "faucet.botSelectorLabels" -}}
app.kubernetes.io/name: {{ include "faucet.name" . }}-bot
app.kubernetes.io/instance: {{ .Release.Name }}-bot
{{- end -}}
{{- define "faucet.serverSelectorLabels" -}}
app.kubernetes.io/name: {{ include "faucet.name" . }}-server
app.kubernetes.io/instance: {{ .Release.Name }}-server
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "faucet.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
    {{ default (include "faucet.fullname" .) .Values.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccount.name }}
{{- end -}}
{{- end -}}
