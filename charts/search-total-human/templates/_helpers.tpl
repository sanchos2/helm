{{- define "search-total-human.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "search-total-human.fullname" -}}
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

{{- define "search-total-human.labels" -}}
helm.sh/chart: {{ printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
app.kubernetes.io/name: {{ include "search-total-human.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{- define "search-total-human.selectorLabels" -}}
app.kubernetes.io/name: {{ include "search-total-human.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{- define "search-total-human.gitSecretName" -}}
{{- if .Values.git.secretName }}
{{- .Values.git.secretName }}
{{- else }}
{{- printf "%s-git" (include "search-total-human.fullname" .) }}
{{- end }}
{{- end }}
