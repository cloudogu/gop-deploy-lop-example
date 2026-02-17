apiVersion: cert-manager.io/v1
kind: Certificate
metadata:
  name: ecosystem-certificate
spec:
  secretName: ecosystem-certificate
  dnsNames:
    - ${config.content.variables.fqdn}
  issuerRef:
    name: letsencrypt-prod
    kind: ClusterIssuer
---
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: allow-ingress-to-acme-solver
spec:
  podSelector:
    matchLabels:
      acme.cert-manager.io/http01-solver: "true"
  policyTypes:
    - Ingress
  ingress:
    - from:
        - podSelector:
            matchLabels:
              k8s.cloudogu.com/component.name: k8s-ces-gateway
      ports:
        - protocol: TCP
          port: 8089