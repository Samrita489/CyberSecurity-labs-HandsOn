Cybersecurity Hands-On Labs Portfolio

Personal cybersecurity learning portfolio | SOC | SIEM | Detection Engineering | Cloud Security

This repository documents three hands-on cybersecurity lab projects completed as part of my practical learning and development in security operations and cloud security.

The projects focus on investigating security logs, developing and testing detection rules, and identifying security misconfigurations in Infrastructure as Code (IaC).

Scope: These are personal lab exercises using sample log data and intentionally vulnerable training configurations. They are not production-environment assessments.

Portfolio at a glance

SIEM Log Investigation | Splunk | Security log analysis, event searches, authentication activity 
Windows Detection Engineering | Sigma, Chainsaw, MITRE ATT&CK Navigator | Detection rules, Windows events, ATT&CK mapping 
Cloud Security Assessment | Checkov, Terraform, TerraGoat, Python | IaC scanning, cloud misconfiguration review, findings dashboard


Lab 01 — SIEM Log Investigation

Objective: Practise investigating Windows log data using Splunk and targeted searches.

Activities documented:
- Explored sample Windows security logs.
- Created targeted searches to review selected security events.
- Investigated Windows Event ID 1102 (Security audit log cleared).
- Created a Top 10 visualisation as part of the investigation.

Tools: Splunk, Windows event log data, Linux log data.
Skills practised:SIEM search, log analysis, event filtering, authentication and security-event investigation.


Lab 02 — Windows Detection Engineering

Objective:Create and test Sigma detection rules against Windows event data using Chainsaw.

Detection areas explored:
- New Windows service installation (Event ID 7045).
- Addition of members to the local Administrators group (Event ID 4732).
- Windows System event log clearing (Event ID 104).
- Windows Security event log clearing (Event ID 1102).

Recorded Chainsaw test run:
- 3 new-service detections.
- 2 local Administrators group-addition detections.
- 1 System event-log-clearing detection.
- The Security event-log-clearing event was found by direct search, but its Sigma rule did not fire in that recorded run.

MITRE ATT&CK Navigator was also used to visualise selected technique mappings. Rule testing and mapping should be considered complete only where the final rule output and mapping evidence are included.

Tools: Sigma, Chainsaw, Windows event data, MITRE ATT&CK Navigator.
Skills practised: Detection-rule authoring, Windows Event ID analysis, rule testing, false-positive awareness and ATT&CK mapping.


Lab 03 — Cloud Security Assessment

Objective: Practise static security scanning of AWS Terraform configurations using Checkov.

Activities documented:
- Scanned the intentionally vulnerable TerraGoat AWS Terraform training project.
- Reviewed Checkov findings, including a hardcoded sample AWS access-key finding.
- Built a Python-based process to convert Checkov JSON output into an HTML findings dashboard and CSV findings table.

Tools: Checkov, Terraform, TerraGoat, Python, HTML.
Skills practised:Infrastructure-as-Code security scanning, cloud misconfiguration review, secrets exposure awareness, findings triage and basic security reporting.
Scope limitation: This was a static Terraform configuration assessment. No AWS infrastructure was deployed, and no live cloud account or runtime assessment was involved. The dashboard uses a simple keyword-based prioritisation approach, not a formal risk-scoring model.


Skills and technologies

- SIEM and log analysis: Splunk
- Detection engineering: Sigma, Chainsaw
- Security frameworks: MITRE ATT&CK Navigator
- Cloud and IaC security:Checkov, Terraform, AWS configuration concepts
- Scripting and reporting: Python, JSON, HTML, CSV
- Investigation skills: Event analysis, findings review, basic triage and documentation

About this portfolio

This repository is intended to demonstrate my practical learning, curiosity and continued development in cybersecurity, particularly SIEM investigation, detection engineering and cloud security.

Author:Amrita Sajikumar
LinkedIn:https://www.linkedin.com/in/amrita-s-secqa/
Contact:s.amrita.cyber@gmail.com
