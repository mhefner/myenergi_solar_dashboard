# CPAP Analyzer

A containerized web application for analyzing CPAP therapy data, currently optimized for Philips DreamStation 2 devices. Deployed and managed using Argo CD for seamless GitOps workflows.

## Features

- **File Upload Support**: Easy drag-and-drop or click-to-upload interface for CPAP data files
- **Philips DreamStation 2 Compatibility**: Optimized parsing and analysis for DreamStation 2 data formats
- **Data Visualization**: Interactive charts and graphs showing sleep therapy metrics
- **Treatment Analysis**: Detailed breakdown of therapy sessions, AHI trends, and compliance tracking
- **Export Functionality**: Generate reports and export analyzed data
- **Privacy-Focused**: All data processing happens client-side in the browser
- **Container-Ready**: Fully containerized for Kubernetes deployment
- **GitOps Integration**: Managed through Argo CD for automated deployments

## Architecture

- **Frontend**: React-based web application
- **Container**: Docker image optimized for production
- **Deployment**: Kubernetes manifests with Argo CD GitOps
- **Storage**: No persistent storage required (client-side processing)

## Deployment

### Prerequisites

- Kubernetes cluster (v1.20+)
- Argo CD installed and configured
- kubectl configured to access your cluster

### Argo CD Deployment

1. **Add the Application to Argo CD**:
```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: cpap-analyzer
  namespace: argocd
spec:
  project: default
  source:
    repoURL: https://github.com/yourusername/cpap-analyzer.git
    targetRevision: main
    path: k8s
  destination:
    server: https://kubernetes.default.svc
    namespace: cpap-analyzer
  syncPolicy:
    automated:
      prune: true
      selfHeal: true
    syncOptions:
    - CreateNamespace=true
```

2. **Apply the Application**:
```bash
kubectl apply -f argocd-application.yaml
```

3. **Monitor Deployment**:
```bash
argocd app get cpap-analyzer
argocd app sync cpap-analyzer
```

### Manual Kubernetes Deployment

If deploying without Argo CD:

```bash
# Create namespace
kubectl create namespace cpap-analyzer

# Apply manifests
kubectl apply -f k8s/ -n cpap-analyzer

# Check deployment status
kubectl get pods -n cpap-analyzer
```

## Kubernetes Manifests

The `k8s/` directory contains:

- `deployment.yaml` - Application deployment configuration
- `service.yaml` - Service exposure configuration
- `ingress.yaml` - Ingress controller configuration (optional)
- `configmap.yaml` - Application configuration
- `hpa.yaml` - Horizontal Pod Autoscaler (optional)

### Configuration

Environment variables can be configured in `k8s/configmap.yaml`:

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: cpap-analyzer-config
data:
  APP_NAME: "CPAP Analyzer"
  MAX_FILE_SIZE: "50MB"
  SUPPORTED_FORMATS: "csv,txt"
```

## Container Image

### Building the Image

```bash
# Build locally
docker build -t cpap-analyzer:latest .

# Tag for registry
docker tag cpap-analyzer:latest your-registry/cpap-analyzer:v1.0.0

# Push to registry
docker push your-registry/cpap-analyzer:v1.0.0
```

### Multi-stage Dockerfile

The application uses a multi-stage build process:
- **Build stage**: Compile and build the React application
- **Runtime stage**: Serve with nginx for optimal performance

## GitOps Workflow

1. **Code Changes**: Push changes to the main branch
2. **CI Pipeline**: Automated build and push of container image
3. **Manifest Update**: Update image tag in Kubernetes manifests
4. **Argo Sync**: Argo CD automatically detects changes and syncs
5. **Deployment**: Application is updated with zero downtime

### Updating the Application

1. Update the image tag in `k8s/deployment.yaml`:
```yaml
spec:
  template:
    spec:
      containers:
      - name: cpap-analyzer
        image: your-registry/cpap-analyzer:v1.1.0  # Updated version
```

2. Commit and push changes:
```bash
git add k8s/deployment.yaml
git commit -m "Update to v1.1.0"
git push origin main
```

3. Argo CD will automatically sync the changes

## Monitoring and Observability

### Health Checks

The application exposes health endpoints:
- `/health` - Basic health check
- `/ready` - Readiness probe endpoint

### Metrics

Prometheus metrics available at `/metrics` endpoint for monitoring:
- Request count and duration
- File upload statistics
- Application performance metrics

## Security

- **No Data Persistence**: All processing happens client-side
- **Container Security**: Runs as non-root user
- **Network Policies**: Kubernetes network policies can be applied
- **HTTPS**: TLS termination at ingress level

## Troubleshooting

### Common Issues

**Pod not starting**:
```bash
kubectl describe pod -l app=cpap-analyzer -n cpap-analyzer
kubectl logs -l app=cpap-analyzer -n cpap-analyzer
```

**Argo CD sync issues**:
```bash
argocd app get cpap-analyzer
argocd app sync cpap-analyzer --force
```

**Image pull errors**:
- Verify image tag exists in registry
- Check imagePullSecrets configuration

## Development

### Local Development

```bash
# Clone repository
git clone https://github.com/yourusername/cpap-analyzer.git
cd cpap-analyzer

# Install dependencies
npm install

# Start development server
npm start
```

### Testing Kubernetes Manifests

```bash
# Validate manifests
kubectl apply --dry-run=client -f k8s/

# Test with kind cluster
kind create cluster --name cpap-analyzer-test
kubectl apply -f k8s/ -n default
```

## Supported File Formats

Currently supports data files from:
- Philips DreamStation 2 (.csv, .txt formats)

*Additional device support planned for future releases*

## Roadmap

- [ ] Helm chart deployment option
- [ ] Support for additional CPAP device manufacturers
- [ ] Advanced analytics and ML-based insights  
- [ ] Multi-tenancy support
- [ ] Integration with health platforms via APIs
- [ ] Progressive Web App features

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Update Kubernetes manifests if needed
4. Test deployment in development cluster
5. Commit changes (`git commit -m 'Add amazing feature'`)
6. Push to branch (`git push origin feature/amazing-feature`)
7. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support

- **Issues**: Open GitHub issues for bugs and feature requests
- **Documentation**: Check `docs/` directory for detailed guides
- **Argo CD**: Refer to [Argo CD documentation](https://argo-cd.readthedocs.io/)

---

**Disclaimer**: This tool is for informational purposes only and should not replace professional medical advice. Always consult with your sleep specialist or healthcare provider regarding your CPAP therapy.