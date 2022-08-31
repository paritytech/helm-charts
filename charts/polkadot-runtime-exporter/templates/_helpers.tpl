{{/*
Return the proper runtime-exporter image name
*/}}
{{- define "runtimeExporter.image" -}}
{{ include "common.images.image" (dict "imageRoot" .Values.image) }}
{{- end -}}

{{/*
Return the proper Docker Image Registry Secret Names
*/}}
{{- define "runtimeExporter.imagePullSecrets" -}}
{{- include "common.images.pullSecrets" (dict "images" (list .Values.image)) -}}
{{- end -}}

{{/*
Create the name of the secret to use
*/}}
{{- define "runtimeExporter.secretName" -}}
{{- if not .Values.runtimeExporter.existingSecretName -}}
    {{ include "common.names.fullname" . }}
{{- else -}}
    {{ .Values.runtimeExporter.existingSecretName }}
{{- end -}}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "runtimeExporter.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
    {{ default (include "common.names.fullname" .) .Values.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Compile all warnings into a single message.
*/}}
{{- define "runtimeExporter.validateValues" -}}
{{- $messages := list -}}
{{- $messages := without $messages "" -}}
{{- $message := join "\n" $messages -}}

{{- if $message -}}
{{-   printf "\nVALUES VALIDATION:\n%s" $message -}}
{{- end -}}
{{- end -}}
