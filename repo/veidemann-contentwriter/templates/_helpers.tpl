{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "veidemann-contentwriter.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "veidemann-contentwriter.fullname" -}}
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
{{- define "veidemann-contentwriter.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a config prefix
If release name contains chart name it will be used as a config prefix
*/}}
{{- define "veidemann-contentwriter.configPrefix" -}}
{{- $name := "veidemann" -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name -}}
{{- end -}}
{{- end -}}

{{/*
Create a claim name
if existingClaim equals "" then use fullname
if existingClaim equals "veidemann-warc" then prefix "warc" with the value of the configPrefix template
else use existingClaim verbatim
*/}}
{{- define "veidemann-contentwriter.claimName" -}}
{{- $name := "warcs" }}
{{- $existingClaim := index .Values.persistence "existingClaim" -}}
{{- if not $existingClaim -}}
    {{- printf "%s-%s" (include "veidemann-contentwriter.fullname" .) $name -}}
{{- else -}}
    {{- if empty (trimSuffix $name $existingClaim) -}}
    {{- printf "%s-%s" (include "veidemann-contentwriter.configPrefix" .) $name -}}
    {{- else -}}
    {{- $existingClaim -}}
    {{- end -}}
{{- end -}}
{{- end -}}
