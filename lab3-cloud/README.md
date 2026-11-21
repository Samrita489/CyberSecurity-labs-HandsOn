
Cloud Security Assessment – Terraform & Checkov

Project Overview

This project demonstrates a hands-on cloud security assessment using Infrastructure as Code (IaC) security scanning.

The assessment involved analysing Terraform configurations from the intentionally vulnerable TerraGoat training environment using Checkov to identify potential cloud security misconfigurations.

A Python-based dashboard was also developed to process scan results and present security findings in a structured and readable format.

Project Objectives

- Understand common cloud infrastructure security risks.
- Assess Terraform configurations for security misconfigurations.
- Use Checkov to perform automated IaC security scanning.
- Review and categorise identified security findings.
- Develop a Python dashboard to visualise scan results.
- Understand the importance of secure cloud configuration.

Tools and Technologies


| Checkov | Infrastructure as Code security scanning |
| Terraform | Cloud infrastructure configuration |
| TerraGoat | Intentionally vulnerable cloud security lab |
| Python | Scan result processing and dashboard development |
| JSON | Structured security scan results |


1. Lab Environment Setup

Used the TerraGoat training environment, which contains intentionally vulnerable Terraform configurations designed for cloud security learning.

2. Infrastructure Security Scanning

Executed Checkov scans against the Terraform configuration files to identify potential security weaknesses and misconfigurations.

3. Findings Analysis

Reviewed the generated scan results, including configuration-related security findings and exposed-secret detection.

Findings were examined to understand their context and potential security implications.

4. Python Dashboard Development

Developed a Python-based dashboard to process Checkov JSON output and present the findings in a more accessible format.

The dashboard uses a basic keyword-based approach to group and prioritise findings for review.

Key Observations

The assessment provided practical exposure to identifying cloud infrastructure security issues.

Examples of observations included:

- Potentially insecure Terraform configurations.
- A test AWS access key detected in the training configuration.
- Network exposure findings requiring contextual review.
- The importance of distinguishing genuine security risks from expected or legitimate configurations.

Not every scanner finding represents an exploitable vulnerability. Findings must be reviewed in the context of the infrastructure configuration.

Project Deliverables

- Terraform configuration assessment.
- Checkov security scan results.
- JSON-based findings output.
- Python dashboard for displaying scan findings.
- Screenshots documenting the assessment process.

Skills Practised

- Cloud security fundamentals
- Infrastructure as Code (IaC) security
- Terraform configuration review
- Checkov security scanning
- Security misconfiguration identification
- JSON data processing
- Python scripting
- Security findings analysis and reporting

Project Limitations

- This was a local, hands-on training lab using TerraGoat.
- No live AWS cloud infrastructure was deployed.
- No Terraform apply operation was performed.
- The dashboard uses basic keyword-based categorisation rather than a formal risk-scoring methodology.
- Remediation and final before-and-after validation were not completed as part of the documented assessment.

Learning Outcomes

Developed practical familiarity with Infrastructure as Code security scanning, cloud misconfiguration assessment, security findings analysis and Python-based reporting.

This project helped build an understanding of how automated security tools can support cloud security reviews and DevSecOps practices.

Disclaimer

This project was conducted solely for educational purposes using an intentionally vulnerable training environment. No production infrastructure or unauthorised systems were accessed.
