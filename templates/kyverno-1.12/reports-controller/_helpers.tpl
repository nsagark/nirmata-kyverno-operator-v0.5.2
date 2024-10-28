{{/* vim: set filetype=mustache: */}}

{{- define "kyverno.reports-controller.name" -}}
{{ template "kyverno.name" . }}-reports-controller
{{- end -}}

{{- define "kyverno.reports-controller.labels" -}}
{{- template "kyverno.labels.merge" (list
  (include "kyverno.labels.common" .)
  (include "kyverno.reports-controller.matchLabels" .)
) -}}
{{- end -}}

{{- define "kyverno.reports-controller.matchLabels" -}}
{{- template "kyverno.labels.merge" (list
  (include "kyverno.matchLabels.common" .)
  (include "kyverno.labels.component" "reports-controller")
) -}}
{{- end -}}

{{- define "kyverno.reports-controller.image" -}}
{{- $imageRegistry := default .image.registry .globalRegistry -}}
{{- if $imageRegistry -}}
  {{ $imageRegistry }}/{{ required "An image repository is required" .image.repository }}:{{ default .defaultTag .image.tag }}
{{- else -}}
  {{ required "An image repository is required" .image.repository }}:{{ default .defaultTag .image.tag }}
{{- end -}}
{{- end -}}

{{- define "kyverno.reports-controller.roleName" -}}
{{ include "kyverno.fullname" . }}:reports-controller
{{- end -}}

{{- define "kyverno.reports-controller.serviceAccountName" -}}
{{- if .Values.kyverno.reportsController.rbac.create -}}
    {{ default (include "kyverno.reports-controller.name" .) .Values.kyverno.reportsController.rbac.serviceAccount.name }}
{{- else -}}
    {{ required "A service account name is required when `rbac.create` is set to `false`" .Values.kyverno.reportsController.rbac.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{- define "kyverno.reports-controller.serviceAnnotations" -}}
  {{- template "kyverno.annotations.merge" (list
    (toYaml .Values.customAnnotations)
    (toYaml .Values.kyverno.reportsController.metricsService.annotations)
  ) -}}
{{- end -}}

{{- define "kyverno.reports-controller.serviceAccountAnnotations" -}}
  {{- template "kyverno.annotations.merge" (list
    (toYaml .Values.customAnnotations)
    (toYaml  .Values.kyverno.reportsController.rbac.serviceAccount.annotations)
  ) -}}
{{- end -}}

{{- define "kyverno.reports-controller.caCertificatesConfigMapName" -}}
{{ printf "%s-ca-certificates" (include "kyverno.reports-controller.name" .) }}
{{- end -}}
