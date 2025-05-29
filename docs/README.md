Building a Robust, Scalable DevSecOps Pipeline for Fullstack MERN Application on AWS: Lessons, Improvements, and Roadmap for Future Work
🚀 Project Overview
As part of my personal project, I built a fullstack MERN (MongoDB, Express.js, React, Node.js) application deployed on AWS with a fully automated, secure, and observable CI/CD pipeline. The goal was to ensure end-to-end automation, leveraging modern DevSecOps practices to enable smooth infrastructure provisioning, secure application deployment, real-time monitoring, and continuous security compliance. This project integrates industry-leading tools like Terraform, Docker, Helm, Argo CD, Prometheus, Grafana, Kubecost, Velero, and Cypress to ensure both performance and security.
Key Components and Tools Deployed
Infrastructure Provisioning with Terraform
VPC Setup: The infrastructure is deployed within a custom Virtual Private Cloud (VPC), including subnets, route tables, and Internet Gateways for secure and scalable networking. This ensures traffic isolation and security at scale.
Improvement: Implemented private subnets for sensitive resources (e.g., MongoDB) and public subnets for web-facing applications (e.g., React frontend), optimizing security and reducing attack surface.
S3 & DynamoDB: We store Terraform's remote state in S3 with DynamoDB for state locking, ensuring reliable state management, and preventing state file conflicts during concurrent runs.
Improvement: Added Terraform state versioning in S3 to ensure rollback capabilities and safeguard against accidental overwrites.
EKS Cluster: We deploy and manage Kubernetes resources using Amazon Elastic Kubernetes Service (EKS). The cluster runs in the VPC with multiple node groups for scalability and fault tolerance.
Improvement: Implemented Kubernetes Horizontal Pod Autoscaling (HPA) to automatically scale pods based on resource usage, improving application responsiveness.
IAM Policies & Node Groups: The EKS cluster utilizes tightly controlled IAM roles and policies to manage permissions securely. IAM roles for Kubernetes service accounts (IRSA) are configured to ensure safe API calls from the Kubernetes cluster to AWS services.
Improvement: Streamlined IAM policy auditing to ensure least privilege access across services.
Jump Server: A Jump EC2 instance is used to provide secure administrative access to the EKS cluster, creating an audit trail for cluster management activities.
Improvement: Configured IAM roles with time-based access control for better security hygiene and compliance.
S3 Buckets: Used for storing backups, Helm charts, and container images. One S3 bucket is dedicated to storing Helm charts for easy deployment via Helm.
Improvement: Implemented lifecycle rules to automatically archive outdated data and logs, reducing storage costs.
________________________________________
File & Folder Structure
fullstack-mern-app/
├── client/                # React frontend app
├── server/                # Node.js backend app
├── fullstack-app/        # Helm chart for fullstack app (client + server + MongoDB)
├── terraform-aws-infra/  # Terraform modules for EKS, VPC, S3, IAM, etc.
├── argo-apps/            # Argo CD application manifests
├── cypress/              # Cypress end-to-end test setup
├── .github/workflows/    # GitHub Actions CI/CD pipeline
├── docs/                 # This documentation
└── README.md             # Root project README
________________________________________
CI/CD with GitHub Actions
Modular Stages: The CI/CD pipeline is divided into multiple stages: linting, testing, build, infrastructure provisioning, deployment, and monitoring. This modularity enhances pipeline maintainability and reusability.
Improvement: Integrated parallel jobs to optimize the pipeline, reducing build times significantly (e.g., parallelizing Docker builds and Helm deployments).
Security Scanning: We integrate Trivy, tfsec, tflint, and SonarCloud into the pipeline to ensure that both the codebase and infrastructure meet high-security standards.
Improvement: Introduced automated dependency scanning in Docker images to catch vulnerabilities early in the development process.
Docker Image Build & Push: Multi-stage Dockerfiles and Docker Compose files are used to build frontend (React) and backend (Node.js) images. These images are then pushed to Docker Hub for deployment.
Improvement: Implemented Docker image versioning and integrated semantic versioning for image tags to enable more granular control over deployments.
Image Scanning: The images are scanned using Trivy to detect vulnerabilities before they are pushed to production. This is critical for container security.
Improvement: Integrated custom vulnerability reports to Slack to provide real-time notifications for newly detected vulnerabilities.
________________________________________
GitOps with Argo CD
Argo CD Integration: We use Argo CD for GitOps-based deployment, where the desired state of the application is stored in a Git repository and synchronized with the Kubernetes cluster.
Improvement: Implemented Argo CD Health Checks for application resources, ensuring faster detection and remediation of issues during deployment.
CLI-Based Sync: The pipeline uses the Argo CD CLI to trigger the synchronization of Kubernetes applications, ensuring deployments are automated and predictable.
Improvement: We streamlined Argo CD sync processes by integrating it more tightly with Helmfile for rollback and environment management.
________________________________________
Helm for Kubernetes Deployment
Helm Charts for Fullstack App & Monitoring: Helm is used for packaging and deploying the fullstack app, Prometheus, Grafana, Kubecost, Velero, and Robusta into the Kubernetes cluster.
MongoDB Image: The MongoDB Helm chart is included to handle persistent storage and deployment of the database, ensuring database resilience across restarts.
Improvement: Introduced Helmfile for multi-chart management, simplifying rollback and environment-specific overrides.
S3-based Helm Chart Storage: We store Helm charts in S3, enabling version control and backup of deployment configurations.
Improvement: Set up automated Helm chart validation during each deployment to ensure consistency and version control.
________________________________________
Monitoring & Alerting with Prometheus, Grafana, Kubecost, & Robusta
Prometheus & Grafana Integration: We use Prometheus for collecting metrics and Grafana for visualizing those metrics in real-time dashboards.
Improvement: Introduced Prometheus Alertmanager to send alerts when thresholds for system performance are crossed.
Robusta for Incident Notifications: Robusta is used to send real-time alerts to Slack about any application failures or incidents.
Improvement: Enhanced Slack integration by categorizing alerts into critical, warning, and info, ensuring better clarity and faster response times.
Kubecost Integration: Kubecost is integrated to track Kubernetes resource costs, allowing us to optimize resource usage and reduce cloud costs.
Improvement: Introduced cost allocation tags to Kubecost for granular cost reporting by service or team.
________________________________________
Backup & Disaster Recovery with Velero
Velero is configured for daily backups of Kubernetes resources (pods, deployments) and persistent volumes (e.g., MongoDB data), ensuring disaster recovery via S3.
Improvement: Integrated cross-region backups using Velero, ensuring data resilience across multiple AWS regions.
CI/CD Pipeline Flow
________________________________________
Step 1: Code Commit
Trigger: Code pushed to GitHub triggers the pipeline.
Challenges:
Delayed commits due to large files: Initial pushes to the repo included large Terraform files that were being tracked by Git, causing CI pipeline slowdowns.
Solution: Added a .gitignore file to exclude .terraform/ directories and large state files from being pushed to the repository, reducing pipeline overhead.
________________________________________
Step 2: Testing
Linting & Testing: The pipeline begins by running SonarCloud for static code analysis to ensure quality and security.
Terraform Scan & Lint: We run tfsec (for security issues) and tflint (for Terraform linting) to catch issues early.
Challenges:
False positives in static analysis: Some Terraform linting errors related to outdated configurations in third-party modules.
Solution: We updated the dependencies for Terraform modules and refined our linting rules to reduce false positives.
________________________________________
Step 3: Docker Image Build & Push
Docker Build Process: We build multi-stage Docker images for the frontend (React) and backend (Node.js) using a Docker Compose file.
Trivy is used to scan the Docker images for any known vulnerabilities before they are pushed to Docker Hub.
Challenges:
Image vulnerabilities: Early stages of the project had Docker images with vulnerabilities due to outdated base images.
Solution: Updated base images to more secure, actively maintained ones and integrated Trivy to scan for vulnerabilities at every build.
________________________________________
Step 4: Infrastructure Provisioning
Terraform:
tfvalidate: Validate the Terraform configurations to ensure they’re correct and adhere to best practices.
tfplan: Generate a plan to show what infrastructure will be created, modified, or destroyed.
tfapply: Apply the Terraform plan to provision VPC, EKS, EC2, IAM roles, S3, DynamoDB backend, etc.
Slack Notifications: Notifications are sent to Slack with the results of the Terraform job (success/failure).
Challenges:
State locking issues: During Terraform apply, some state lock issues were encountered due to concurrent runs.
Solution: Set up DynamoDB locking to prevent simultaneous apply operations, ensuring only one Terraform apply could run at a time.
________________________________________
Step 5: Helm Deployment
Helm Package & Push: After Terraform has successfully provisioned the infrastructure, the Helm charts for Fullstack app, Prometheus, Grafana, Kubecost, Velero, and Robusta are packaged and pushed to S3 for backup and version control.
MongoDB Helm Chart: The MongoDB Helm chart is included to handle persistent storage and deployment of the database.
Challenges:
MongoDB Helm Deployment Failures: The MongoDB Helm chart caused conflicts with Kubernetes CRDs due to leftover resources from previous deployments.
Solution: We manually cleaned up the CRDs and implemented Helmfile to manage complex rollbacks and re-deployments more effectively.
________________________________________
Step 6: Deployment
Argo CD: Argo CD is used to deploy all Helm charts into the Kubernetes cluster, ensuring all applications (Fullstack app, Prometheus, Grafana, Kubecost, Velero, Robusta) are correctly deployed and synchronized with the Git repository.
Challenges:
Token Authentication Errors: Early deployments failed due to token issues with Argo CD's sync process.
Solution: Switched to CLI-based sync with Bearer tokens, resolving authentication issues and ensuring smoother synchronization.
________________________________________
Step 7: Health Check & E2E Testing
Deployment Health Check: After the deployment, a health check is performed to ensure the services are running correctly.
Cypress E2E Tests: Cypress tests are executed to perform end-to-end (E2E) testing of the application, validating that all features work as expected in a production-like environment.
Challenges:
Slow Health Checks: Health checks were slow due to unoptimized endpoints.
Solution: Optimized the health check endpoints to only return minimal data for faster responses, ensuring quick validation.
________________________________________
Step 8: Rollback on Failure
Rollback: If any of the steps fail, the pipeline triggers a rollback using Helm to revert the app to a stable state.
Challenges:
Incomplete Rollbacks: Initial rollbacks left some resources hanging due to improper Helm configurations.
Solution: Enhanced Helmfile to ensure complete rollback of resources by tracking and cleaning up dependent resources during failure.
________________________________________
Step 9: Slack Notifications
Once the pipeline is complete (success or failure), notifications are sent to Slack with the status of the deployment.
________________________________________
Secret Management
We use GitHub Secrets to securely manage sensitive information. The secrets are stored securely and are referenced within the pipeline:
ARGOCD_TOKEN: Argo CD authentication token.
EKS_CLUSTER_NAME: Name of the EKS cluster.
AWS_ACCESS_KEY_ID & AWS_SECRET_ACCESS_KEY: AWS credentials for accessing and provisioning resources.
SOPS_AGE_KEY: Encryption key for managing secrets in Helmfile using SOPS and age.
We avoid hardcoding sensitive data in code by securely retrieving these secrets during the pipeline execution.
Challenges & Troubleshooting Summary
For each stage, we encountered specific issues such as CrashLoopBackOff errors, PVC binding issues, and Argo CD sync failures. However, through continuous troubleshooting, manual fixes (like cleaning up leftover CRDs), and optimizing configurations, we were able to resolve these issues and ensure the pipeline ran smoothly, ultimately leading to a production-ready solution.
________________________________________
Future Work & Roadmap
Enhancing Security:
Tighten IAM roles and policies to adhere to the principle of least privilege.
Implement Network Policies for Kubernetes to restrict pod-to-pod communication.
Modular Terraform Infrastructure:
Split the infrastructure into smaller, reusable modules for scalability across environments (dev, staging, prod).
Blue/Green Deployment:
Implement Blue/Green deployments for easy migration between cloud providers like Azure or GCP while minimizing downtime.
Optimizing CI/CD Pipeline:
Parallelize steps like Docker builds and Helm deployments to reduce pipeline execution time.
Use GitHub Actions matrix builds to test multiple versions of Node.js and React.
GitOps Enhancements:
Integrate Helmfile to improve Helm chart management and Kustomize for environment-specific configurations.
References, Documentation & AI Assistance
This project leveraged key resources, expert tutorials, and AI-powered tools to optimize the pipeline, troubleshoot issues, and improve development efficiency:
1. Documentation
GitHub Actions Docs: Essential for creating modular CI/CD workflows and optimizing pipeline performance with matrix builds.
Terraform Docs: Guided infrastructure provisioning with state management using S3 and DynamoDB.
Kubernetes & Argo CD Docs: Helped implement GitOps workflows and secure Kubernetes network policies.
Helm Docs: Used for packaging and deploying Helm charts for MongoDB, Prometheus, Grafana, Kubecost, and Velero.
2. YouTube Tutorials
Abhishek Veeramalla: Tutorials on Kubernetes and Terraform helped optimize multi-cloud deployments and CI/CD automation.
Nasiullah Chaudhari: Provided insights into Helm and GitOps integration, especially with Argo CD.
Audrey Turco (Head of DevOps, JOOR): Audrey’s lessons on building safer, faster, and cheaper pipelines taught me about automated checks, cost optimization with kubectl-cost, and Velero for disaster recovery.
3. AI-Powered Tools
GitHub Copilot: Used to auto-generate code snippets, suggest fixes, and speed up development by providing context-aware code recommendations.
VSCode Copilot: Integrated directly into Visual Studio Code to assist in real-time code suggestions and debugging while writing Terraform and Helm configurations.
ChatGPT (AI-Assisted Troubleshooting): Used to troubleshoot complex issues related to Kubernetes networking, Argo CD sync errors, and Helm chart management. ChatGPT helped identify optimal solutions, recommend configuration changes, and clarify DevOps best practices.
Kube-score & Kubespy: AI-powered tools for Kubernetes troubleshooting, helping debug misconfigurations and optimizing Ingress routing.
Helm Diff & Helmfile: AI-assisted tools for detecting Helm configuration drift, suggesting improvements, and streamlining rollback processes.
4. Security & Compliance Tools
SonarCloud: Automated static code analysis for security and code quality.
Trivy: Scanned Docker images for vulnerabilities, ensuring security before deployment.
tfsec & tflint: Validated Terraform configurations, enforcing security standards.
📚 References, Documentation & AI Assistance
Official Documentation
•	GitHub Actions
•	Terraform by HashiCorp
•	Kubernetes Docs
•	Helm
•	Argo CD
•	Velero
•	Kubecost
•	Prometheus
YouTube Tutorials That Helped
•	DevOps with Abhishek – Abhishek Veeramalla

Conclusion
This project has been a significant journey in applying DevSecOps practices to build a scalable, secure, and automated CI/CD pipeline for a fullstack MERN application. Through hands-on experience with Terraform, Kubernetes, Helm, Argo CD, and cloud-native architectures, I was able to create a platform that ensures continuous deployment, real-time monitoring, and end-to-end security.
Key to this project’s success were AI-powered tools like GitHub Copilot, VSCode Copilot, and ChatGPT, which helped accelerate development and streamline troubleshooting, enhancing my workflow. By leveraging modern tools and best practices, I built a solution that is not only production-ready but also resilient, cost-efficient, and future-proof.
With a focus on security, cost optimization, and scalability, I am ready to contribute to real-world DevOps challenges, continuously improve infrastructure, and build cloud-native pipelines for modern applications. Whether working on multi-cloud deployments, microservices architecture, or CI/CD automation, I am eager to bring these skills to a team looking for someone who thrives in dynamic, fast-paced environments.
If you're hiring for a DevOps Engineer or Cloud Engineer, or want to discuss modern infrastructure automation, CI/CD best practices, or DevSecOps, feel free to connect. I’m passionate about sharing insights, learning from others, and contributing to cutting-edge DevOps solutions. Let's connect and build the future of technology together!
Key Skills
Cloud Platforms: AWS (EKS, EC2, S3, DynamoDB, IAM)
Infrastructure as Code (IaC): Terraform (VPC, EKS, EC2, IAM, S3)
CI/CD Tools: GitHub Actions, Argo CD, Helm, Docker
Containerization & Orchestration: Docker, Kubernetes (EKS), Helm, kubectl
Security & Compliance: Trivy, SonarCloud, tfsec, tflint, SOPS (for secret management)
Monitoring & Logging: Prometheus, Grafana, Kubecost, Robusta
Backup & Disaster Recovery: Velero
Scripting & Automation: Bash, Python, YAML
Version Control: Git, GitHub
Application Performance Monitoring: Grafana Dashboards, Prometheus metrics
Cost Optimization: Kubecost, lifecycle policies for S3/ECR
