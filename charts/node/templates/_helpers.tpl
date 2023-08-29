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
{{- if or .Values.node.chainData.pruning ( not ( kindIs "invalid" .Values.node.chainData.pruning ) ) }}
{{- if ge ( int .Values.node.chainData.pruning ) 1 }}
pruning: {{ .Values.node.chainData.pruning | quote }}
{{- else if and ( not ( kindIs "invalid" .Values.node.chainData.pruning ) ) ( eq 0 ( int .Values.node.chainData.pruning ) ) }}
pruning: archive
{{- end }}
{{- end }}
{{- if .Values.node.chainData.database }}
database: {{ .Values.node.chainData.database }}
{{- end }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "node.selectorLabels" -}}
app.kubernetes.io/name: {{ include "node.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/component: substrate-node
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
{{- if eq .Values.node.chainData.database "paritydb" }}
{{- "paritydb" }}
{{- else }}
{{- "db" }}
{{- end }}
{{- end }}

{{/*
Define a regex matcher to check if the passed node flags are managed by the chart already
*/}}
{{- define "node.chartManagedFlagsRegex" -}}
{{- "(\\W|^)(--name|--base-path|--chain|--validator|--collator|--light|--database|--pruning|--prometheus-external|--prometheus-port|--node-key|--wasm-runtime-overrides|--jaeger-agent|--rpc-external|--unsafe-rpc-external|--ws-external|--unsafe-ws-external|--rpc-methods|--rpc-cors|--rpc-port|--ws-port|--enable-offchain-indexing)(\\W|$)" }}
{{- end }}
