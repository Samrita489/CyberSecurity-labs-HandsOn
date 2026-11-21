
SOC Detection Engineering – Sigma Rules and Windows Event Analysis

Project Overview

This project explores practical detection engineering using Sigma rules, Chainsaw and Windows Event Logs.

The objective was to create and test detection rules for selected Windows security events, investigate the generated results and understand how detections can be mapped to the MITRE ATT&CK framework.

Objectives

- Understand Sigma detection rule structure.
- Develop custom rules for selected Windows security events.
- Analyse Windows EVTX log files using Chainsaw.
- Review detection results and investigate event matches.
- Explore MITRE ATT&CK technique mapping.
- Practise basic detection validation and false-positive awareness.

Tools and Technologies

- Sigma
- Chainsaw
- Windows Event Logs (EVTX)
- MITRE ATT&CK Navigator


Methodology

1. Reviewed the relevant Windows event logs.
2. Created custom Sigma detection rules for selected scenarios.
3. Used Chainsaw to analyse EVTX files against the detection rules.
4. Reviewed rule matches and investigated the corresponding events.
5. Examined detection gaps and potential false positives.
6. Explored mapping detections to MITRE ATT&CK.

Testing Observations

Chainsaw produced matches for several detection scenarios, including new service installation, System event log clearing and local Administrators group membership changes.

The Security event log clearing scenario (Event ID 1102) was also identified during direct log investigation, but the corresponding Sigma rule did not produce a match in the initial Chainsaw test.

This highlighted the importance of validating detection rules against actual log data and refining rules where necessary.

Evidence

- Sigma rule files
- Chainsaw analysis results
- Windows event investigation screenshots
- MITRE ATT&CK mapping evidence

See the corresponding project folders for available evidence.

Skills Practised

- Detection engineering fundamentals
- Sigma rule development
- Windows security event analysis
- EVTX log investigation
- Chainsaw-based detection testing
- MITRE ATT&CK framework awareness
- Basic detection validation

Project Limitations

This was a personal hands-on lab using available Windows event log data. It was not deployed in a production SOC environment.

Some detection scenarios required further rule refinement and validation. The project should therefore be considered practical learning and experimentation rather than a fully validated production detection package.

Learning Outcome

Developed practical familiarity with creating and testing detection rules, analysing Windows security events and understanding how detection logic supports security monitoring and incident investigation.
