{{/*
Expand the name of the chart.
*/}}
{{- define "autonomously.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "autonomously.fullname" -}}
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
{{- define "autonomously.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "autonomously.labels" -}}
helm.sh/chart: {{ include "autonomously.chart" . }}
app.kubernetes.io/part-of: a10y
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Component full name: <release>-<component>
*/}}
{{- define "autonomously.componentName" -}}
{{- printf "%s-%s" .root.Release.Name .name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Component labels
*/}}
{{- define "autonomously.componentLabels" -}}
{{ include "autonomously.labels" .root }}
app.kubernetes.io/name: {{ .name }}
app.kubernetes.io/component: {{ .name }}
app.kubernetes.io/instance: {{ .root.Release.Name }}
{{- end }}

{{/*
Component selector labels
*/}}
{{- define "autonomously.componentSelectorLabels" -}}
app.kubernetes.io/name: {{ .name }}
app.kubernetes.io/instance: {{ .root.Release.Name }}
{{- end }}
