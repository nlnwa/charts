{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "veidemann-contentexplorer.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "veidemann-contentexplorer.fullname" -}}
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

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "veidemann-contentexplorer.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a config prefix
If release name contains chart name it will be used as a config prefix
*/}}
{{- define "veidemann-contentexplorer.configPrefix" -}}
{{- $name := "veidemann" -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name -}}
{{- end -}}
{{- end -}}

{{/*
Create a claim name
If existingClaim equals "" then prefix name with fullname template,
else if existingClaim equals "veidemann-warc" then prefix name with the configPrefix template,
else use existingClaim verbatim.
*/}}
{{- define "veidemann-contentexplorer.claimName" -}}
{{- $name := "warcs" }}
{{- $existingClaim := index .Values.persistence "existingClaim" -}}
{{- if not $existingClaim -}}
    {{- printf "%s-%s" (include "veidemann-contentexplorer.fullname" .) $name -}}
{{- else -}}
    {{- if eq "veidemann-" (trimSuffix $name $existingClaim) -}}
    {{- printf "%s-%s" (include "veidemann-contentexplorer.configPrefix" .) $name -}}
    {{- else -}}
    {{- $existingClaim -}}
    {{- end -}}
{{- end -}}
{{- end -}}

