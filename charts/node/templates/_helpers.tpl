{{/*
Expand the name of the chart.
*/}}
{{- define "node.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "node.fullname" -}}
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
{{- define "node.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "node.labels" -}}
helm.sh/chart: {{ include "node.chart" . }}
{{ include "node.selectorLabels" . }}
{{ include "node.serviceLabels" . }}
app.kubernetes.io/version: {{ .Values.image.tag | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
chain: {{ .Values.node.chain }}
role: {{ .Values.node.role }}
{{- if or .Values.node.pruning ( not ( kindIs "invalid" .Values.node.pruning ) ) }}
{{- if ge ( int .Values.node.pruning ) 1 }}
pruning: {{ .Values.node.pruning | quote }}
{{- else if and ( not ( kindIs "invalid" .Values.node.pruning ) ) ( eq 0 ( int .Values.node.pruning ) ) }}
pruning: archive
{{- end }}
{{- end }}
{{- if .Values.node.database }}
database: {{ .Values.node.database }}
{{- end }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "node.selectorLabels" -}}
app.kubernetes.io/name: {{ include "node.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Service labels
*/}}
{{- define "node.serviceLabels" -}}
chain: {{ .Values.node.chain }}
release: {{ .Release.Name }}
role: {{ .Values.node.role }}
{{- with .Values.extraLabels }}
{{ toYaml . }}
{{- end }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "node.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "node.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create the database path depending on the database backend in use (rocksdb or paritydb)
*/}}
{{- define "node.databasePath" -}}
{{- if eq .Values.node.database "paritydb" }}
{{- "paritydb" }}
{{- else }}
{{- "db" }}
{{- end }}
{{- end }}
