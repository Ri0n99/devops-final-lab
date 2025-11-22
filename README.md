<<<<<<< HEAD
Ky projekt tregon një setup DevOps duke përdorur Kubernetes, Docker, Terraform, Prometheus dhe Grafana. Projekti përfshin:

Infrastrukturën (Terraform) – për krijimin e environment-it bazik.

Aplikacionet (API & Worker) – të container-izuara me Docker.

Kubernetes objects (YAML) – për deploy e servisa të API dhe worker.
---------------------------------------------------------------------
-STRUKTURE E PROJEKTIT-
Monitoring – Grafana dashboards dhe Prometheus alerts.
devops-final-lab/
├── infra/                  # Terraform configuration
├── k8s/                    # Kubernetes manifests
│   ├── api-deployment.yaml
│   ├── api-service.yaml
│   ├── worker-deployment.yaml
│   └── monitoring/         # Monitoring manifests
├── app/                    # Dockerized api + worker
├── client/                 # Dockerized client
├── dashboards/             # Grafana dashboards JSON
├── alerts/                 # PrometheusRule YAML
├── docs/                   # Documentation, diagrams, screenshots
├── docker-compose.yml
├── package.json
├── package-lock.json
└── .gitkeep
--------------------------------------------------------------------
-HAPAT E KRYERS- 
Hapat e kryera
1. Docker containers

API:

Build: ./app/api

Port: 4000

/metrics për Prometheus

Worker:

Build: ./worker

Monitoron queues dhe proceset e punës

Client:

Build: ./client

Port: 5000

Testimi: docker-compose up --build dhe kontrollimi i porteve me localhost:4000 për API dhe localhost:5000 për Client.
---------------------------------------------------------------------------
-KUBERNETES DEPLOYMENTS-
Namespaces krijuar:

app për API dhe Worker

monitoring për Prometheus dhe Grafana

API & Worker deployments:

Përdorim image: api:latest dhe image: worker:latest

Readiness & Liveness Probes të konfiguruara

kubectl apply -f k8s/api-deployment.yaml -n app

kubectl apply -f k8s/worker-deployment.yaml -n app

Servisa:

NodePort për API: 3000 (port-forward 4000:3000)

NodePort për Worker nuk është nevojitur për testing.

Testimi: kubectl get pods -n app për të siguruar që container-at janë Running.
----------------------------------------------------------------------------------
-MONITORING-

Grafana dashboard:

JSON i krijuar për të monitoruar: latency e API, madhësia e queues në worker, CPU dhe memory usage.

Aplikuar me port-forward:

kubectl port-forward svc/grafana-service 8080:3000 -n monitoring


Shikohet në localhost:8080.

Prometheus alerts:

api-alert.yaml dhe worker-alert.yaml

Përkujdesen për metrikat kritike të API dhe worker

Testuar me kubectl apply -f alerts/api-alert.yaml -n monitoring
-------------------------------------------------------------------------------------
-TERRAFORM(INFRA)-
Setup minimal i resource-ve (nuk kishte ndryshime të reja pasi apply ishte i bërë më parë)

Idempotent: terraform plan nuk ka ndryshime

File infra/main.tf i gati për të krijuar stack-in në cloud ose lokalisht.
--------------------------------------------------------------------------------------
-TESTIMI I PERGJITHSHEM-
Testimi i përgjithshëm

API dhe Worker containerat janë të Running

Dashboard dhe alerts janë të aplikuara

K8s pods janë në namespace app dhe monitoring

Terraform konfirmon se nuk ka ndryshime të reja.
---------------------------------------------------------------------------------------
-Hapa të ardhshëm për të përfunduar projektin-

Deploy i client dhe sigurimi që interakton me API

Autoscaling i pods bazuar në load

Screenshots e dashboards dhe alert test

Plotësimi i docs me diagram arkitekture dhe runbook
=======
# DevOps Final Lab
>>>>>>> master
