{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "veidemann-warcvalidator.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "veidemann-warcvalidator.fullname" -}}
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
{{- define "veidemann-warcvalidator.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a config prefix
If release name contains chart name it will be used as a config prefix
*/}}
{{- define "veidemann-warcvalidator.configPrefix" -}}
{{- $name := "veidemann" -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name -}}
{{- end -}}
{{- end -}}

{{/*
Create a claim name
*/}}
{{- define "veidemann-warcvalidator.claimName" -}}
{{- $suffix := .name -}}
{{- $root := .root -}}
{{- $existingClaim := index $root.Values.persistence $suffix "existingClaim" -}}
{{- if not $existingClaim -}}
    {{- printf "%s-%s" (include "veidemann-warcvalidator.fullname" $root) $suffix -}}
{{- else -}}
    {{- if eq "veidemann-" (trimSuffix $suffix $existingClaim) -}}
    {{- printf "%s-%s" (include "veidemann-warcvalidator.configPrefix" $root) $suffix -}}
    {{- else -}}
    {{- $existingClaim -}}
    {{- end -}}
{{- end -}}
{{- end -}}
