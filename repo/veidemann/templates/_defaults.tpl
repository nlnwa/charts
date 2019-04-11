{{- define "veidemann.controller.host" -}}      {{ printf "%s-%s" .Release.Name .Values.default.controller.host | trunc 63 | trimSuffix "-" }}{{- end -}}
{{- define "veidemann.frontier.host" -}}        {{ printf "%s-%s" .Release.Name .Values.default.frontier.host | trunc 63 | trimSuffix "-" }}{{- end -}}
{{- define "veidemann.cache.host" -}}           {{ printf "%s-%s" .Release.Name .Values.default.cache.host | trunc 63 | trimSuffix "-" }}{{- end -}}
{{- define "veidemann.dnsResolver.host" -}}     {{ printf "%s-%s" .Release.Name .Values.default.dnsResolver.host | trunc 63 | trimSuffix "-" }}{{- end -}}
{{- define "veidemann.harvester.host" -}}       {{ printf "%s-%s" .Release.Name .Values.default.harvester.host | trunc 63 | trimSuffix "-" }}{{- end -}}
{{- define "veidemann.contentWriter.host" -}}   {{ printf "%s-%s" .Release.Name .Values.default.contentWriter.host | trunc 63 | trimSuffix "-" }}{{- end -}}
{{- define "veidemann.robotsEvaluator.host" -}} {{ printf "%s-%s" .Release.Name .Values.default.robotsEvaluator.host | trunc 63 | trimSuffix "-" }}{{- end -}}
{{- define "veidemann.oosHandler.host" -}}      {{ printf "%s-%s" .Release.Name .Values.default.oosHandler.host | trunc 63 | trimSuffix "-" }}{{- end -}}
