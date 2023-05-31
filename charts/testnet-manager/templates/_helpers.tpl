{{/*
Expand the name of the chart.
*/}}
{{- define "testnet-manager.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "testnet-manager.fullname" -}}
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
{{- define "testnet-manager.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 48 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "testnet-manager.labels" -}}
helm.sh/chart: {{ include "testnet-manager.chart" . }}
{{ include "testnet-manager.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- with .Values.extraLabels }}
{{ toYaml . }}
{{- end }}
{{- end }}

{{/*
testnet-manager Server Selector labels
*/}}
{{- define "testnet-manager.selectorLabels" -}}
app.kubernetes.io/name: {{ include "testnet-manager.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
testnet-manager Task-Scheduler Selector labels
*/}}
{{- define "testnet-manager.taskSchedulerSelectorLabels" -}}
app.kubernetes.io/name: {{ include "testnet-manager.name" . }}-task-scheduler
app.kubernetes.io/instance: {{ .Release.Name }}-task-scheduler
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "testnet-manager.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "testnet-manager.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create the name of the external-validators configmap to use
*/}}
{{- define "testnet-manager.external-validators-configmap" -}}
{{- printf "%s-external-validators" (include "testnet-manager.fullname" .) }}
{{- end }}
