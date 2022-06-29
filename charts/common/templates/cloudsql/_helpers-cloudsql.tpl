{{/*
cloudsql fullname
*/}}
{{- define "common.cloudsqlFullname" -}}
{{ include "common.fullname" . }}-cloudsql
{{- end }}

{{- define "common.cloudsqlComponent" -}}
app.kubernetes.io/component: cloudsql
{{- end }}

{{/*
cloudsql common labels
*/}}
{{- define "common.cloudsqlLabels" -}}
{{- $componentLabels := fromYaml (include "common.cloudsqlComponent" .) -}}
{{- $commonLabels := fromYaml (include "common.labels" .) -}}
{{- $labels := merge $componentLabels $commonLabels -}}
{{ toYaml $labels }}
{{- end }}

{{/*
cloudsql selector labels
*/}}
{{- define "common.cloudsqlSelectorLabels" -}}
{{- $componentLabels := fromYaml (include "common.cloudsqlComponent" .) -}}
{{- $selectorLabels := fromYaml (include "common.selectorLabels" .) -}}
{{- $labels := merge $componentLabels $selectorLabels -}}
{{ toYaml $labels }}
{{- end }}