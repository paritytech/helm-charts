{{/*
Expand the name of the chart.
*/}}
{{- define "polkadot-stps.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "polkadot-stps.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "polkadot-stps.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "polkadot-stps.labels" -}}
helm.sh/chart: {{ include "polkadot-stps.chart" . }}
{{ include "polkadot-stps.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- with .Values.extraLabels }}
{{ toYaml . }}
{{- end }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "polkadot-stps.selectorLabels" -}}
app.kubernetes.io/name: {{ include "polkadot-stps.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}


{{/*
TPS Selector labels
*/}}
{{- define "polkadot-stps-tps.selectorLabels" -}}
{{ include "polkadot-stps.selectorLabels" . }}
stps/app: tps
{{- end }}

{{/*
Sender Selector labels
*/}}
{{- define "polkadot-stps-sender.selectorLabels" -}}
{{ include "polkadot-stps.selectorLabels" . }}
stps/app: sender
{{- end }}

{{/*
Define a regex matcher to check if the role is supported
*/}}
{{- define "stps.rolesSupported" -}}
{{- "^(block-time|parachain-tracer)$" }}
{{- end }}
