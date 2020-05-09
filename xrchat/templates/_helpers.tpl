{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
# {{- define "xrchat.name" -}}
# {{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
# {{- end -}}

{{- define "xrchat.client.name" -}}
{{- default .Chart.Name .Values.client.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "xrchat.apiServer.name" -}}
{{- default .Chart.Name .Values.apiServer.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "xrchat.mediaServer.name" -}}
{{- default .Chart.Name .Values.mediaServer.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "xrchat.spoke.name" -}}
{{- default .Chart.Name .Values.spoke.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}


{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "xrchat.fullname" -}}
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


{{- define "xrchat.client.fullname" -}}
{{- if .Values.client.fullnameOverride -}}
{{- .Values.client.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name .Values.client.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}


{{- define "xrchat.apiServer.fullname" -}}
{{- if .Values.apiServer.fullnameOverride -}}
{{- .Values.apiServer.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name .Values.apiServer.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}


{{- define "xrchat.mediaServer.fullname" -}}
{{- if .Values.mediaServer.fullnameOverride -}}
{{- .Values.mediaServer.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name .Values.mediaServer.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{- define "xrchat.spoke.fullname" -}}
{{- if .Values.spoke.fullnameOverride -}}
{{- .Values.spoke.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name .Values.spoke.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{- define "xrchat.client.host" -}}
{{- printf "%s.%s.%s" "dashboard" .Release.Name .Values.domain -}}
{{- end -}}


{{- define "xrchat.mediaServer.host" -}}
{{- printf "%s.%s.%s" "api" .Release.Name .Values.domain -}}
{{- end -}}



{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "xrchat.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "xrchat.client.labels" -}}
helm.sh/chart: {{ include "xrchat.chart" . }}
{{ include "xrchat.client.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "xrchat.client.selectorLabels" -}}
app.kubernetes.io/name: {{ include "xrchat.client.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/component: client
{{- end -}}


{{/*
Common labels
*/}}
{{- define "xrchat.apiServer.labels" -}}
helm.sh/chart: {{ include "xrchat.chart" . }}
{{ include "xrchat.apiServer.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "xrchat.apiServer.selectorLabels" -}}
app.kubernetes.io/name: {{ include "xrchat.apiServer.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/component: server
{{- end -}}


{{/*
Common labels
*/}}
{{- define "xrchat.mediaServer.labels" -}}
helm.sh/chart: {{ include "xrchat.chart" . }}
{{ include "xrchat.mediaServer.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "xrchat.mediaServer.selectorLabels" -}}
app.kubernetes.io/name: {{ include "xrchat.mediaServer.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/component: server
{{- end -}}



{{/*
Common labels
*/}}
{{- define "xrchat.spoke.labels" -}}
helm.sh/chart: {{ include "xrchat.chart" . }}
{{ include "xrchat.spoke.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "xrchat.spoke.selectorLabels" -}}
app.kubernetes.io/name: {{ include "xrchat.spoke.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/component: spoke
{{- end -}}


{{/*
Create the name of the service account to use
*/}}
{{- define "xrchat.client.serviceAccountName" -}}
{{- if .Values.client.serviceAccount.create -}}
    {{ default (include "xrchat.client.fullname" .) .Values.client.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.client.serviceAccount.name }}
{{- end -}}
{{- end -}}


{{/*
Create the name of the service account to use
*/}}
{{- define "xrchat.apiServer.serviceAccountName" -}}
{{- if .Values.apiServer.serviceAccount.create -}}
    {{ default (include "xrchat.apiServer.fullname" .) .Values.apiServer.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.apiServer.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "xrchat.mediaServer.serviceAccountName" -}}
{{- if .Values.mediaServer.serviceAccount.create -}}
    {{ default (include "xrchat.mediaServer.fullname" .) .Values.mediaServer.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.mediaServer.serviceAccount.name }}
{{- end -}}
{{- end -}}


{{/*
Create the name of the service account to use
*/}}
{{- define "xrchat.spoke.serviceAccountName" -}}
{{- if .Values.spoke.serviceAccount.create -}}
    {{ default (include "xrchat.spoke.fullname" .) .Values.spoke.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.spoke.serviceAccount.name }}
{{- end -}}
{{- end -}}


{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "xrchat.mariadb.fullname" -}}
{{- if .Values.mariadb.fullnameOverride -}}
{{- .Values.mariadb.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.mariadb.nameOverride -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}


{{/*
Set maria host
*/}}
{{- define "xrchat.mariadb.host" -}}
{{- if .Values.mariadb.enabled -}}
{{- template "xrchat.mariadb.fullname" . -}}
{{- else -}}
{{- .Values.mariadb.externalHost | quote -}}
{{- end -}}
{{- end -}}
