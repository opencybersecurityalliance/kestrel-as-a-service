.. image:: logo/kaas-logo-san-serif-cloud.png
   :width: 432
   :alt: Kestrel as a Service

**Kestrel as a Service (KaaS)** is a Kestrel container and deployable cloud-managed hunting service for large organizations.  This project will provide the code and instructions for deploying a Threat Hunting Team Enterprise Solution that is focused on being scalable, persistent and collaborative.  The Getting Started Guide folder has the documentation for Architecture, Deployment and further use case detail.

**What is the problem space we are addressing?** Threat hunting can be slow and tedious due to the manual steps required. Kestrel is an open source project that provides a language for humans to express what to hunt and a machine interpreter that deals with how to hunt.  Although Kestrel improves the time to detect, there are limitations to team capabilities in threat hunting tools and standards. The power of team threat hunting may be able to remove the limitations, therefore, increasing the MTTD, achieved by combining Kestrel with JupyterHub hunts with Kestrel huntbooks in order to be persistent and shared by team members. 

**What is the solution?**  The intent of Cyber Threat Hunting is to proactively find bad actors in our environment.  This means we want to improve the scalability and automation of threat hunting capabilities.  We can track improvements of our hunts by tracking the Mean Time to Detect (MTTD) which also impacts the Mean Time to Contain (MTTC), and the Mean Time to Repair (MTTR). The goal of this paper is to show how to accelerate threat hunting in an automated fashion to reduce the gap from cyber attack to incident resolution, but in a continuous security manner. Through Kestrel Threat hunt books and analytics, along with other standards and tools we can create hunt books and analytics that can be shared with the community that in turn decrease the Mean Time of Detection.  

**What are the technologies used in the reference architecture?** 

- Red Hat Enterprise Linux v8.7
- Minikube version: v1.29.0
- Helm version: v3.11.1
- VirtualBox 7.0.2
- Ansible core 2.13.3
- Podman version 4.2.0
- JupyterHub
- Kestrel-lang
- Kestrel-analytics
- ELK Stack
- Keycloak

:Authors:
    Kenneth Peeples,
    Xiaokui Shu, and
    Claudia Rauch

:Version: 1.0 of 2023/03/15
:Dedication: For my Dad, Keith Peeples, and Mom, DiAnn Peeples, who were both pioneers in Computer Science from the 1950's into the 2000's in banking, law enforcement and health care.

