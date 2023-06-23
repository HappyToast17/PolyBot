{{/* helpers.tpl */}}
{{- define "my-python-app.fullname" -}}
{{- printf "%s-%s" .Release.Name .Chart.Name -}}
{{- end -}}

{{- define "my-python-app.name" -}}
{{- .Chart.Name -}}
{{- end -}}
