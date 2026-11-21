# Lab 1 - Splunk searches

Set the time range to **All time** for every search.
Field names depend on how Splunk parsed the JSON: expand an event and check the exact names if a column is empty.

## Check what is loaded
```
index=main | stats count by source, sourcetype
```

## A. Linux SSH brute force (T1110.001)
Failed logins per source, worst first:
```
index=main "authentication failure" | rex "rhost=(?<src>\S+)" | stats count by src | sort -count
```
Top 10 (use Visualization > Column chart for the report):
```
index=main "authentication failure" | rex "rhost=(?<src>\S+)" | stats count by src | sort -count | head 10
```
Accounts the top attacker tried:
```
index=main "authentication failure" rhost=150.183.249.110 | rex "user=(?<target_user>\S+)" | stats count by target_user
```
How long the attack lasted:
```
index=main "authentication failure" rhost=150.183.249.110 | stats count, earliest(_time) as first_seen, latest(_time) as last_seen | convert ctime(first_seen) ctime(last_seen)
```
Did any login succeed? (zero results is a valid finding)
```
index=main sshd ("Accepted password" OR "session opened")
```

## B. Windows hunts (JSON sources converted with Chainsaw)
Confirm all five files loaded (a file ending in `.jso` would be missed by `*.json`):
```
index=main source="*.json" | stats count by source
index=main source="*Guest*" | stats count by source
```
Hunt A - Security log cleared, Event 1102 (T1685.005, formerly T1070.001):
```
index=main source="*DE_1102*" | table _time Event.System.EventID Event.System.Computer Event.System.Channel
```
Hunt B - System log cleared, Event 104:
```
index=main source="*DE_104*" | table _time Event.System.EventID Event.System.Computer Event.System.Channel
```
Hunt C - new service installed, Event 7045 (T1543.003 / T1569.002):
```
index=main source="*7045*" | table _time Event.System.EventID Event.EventData.ServiceName Event.EventData.ImagePath Event.EventData.AccountName
```
Hunt D - credential theft tooling (T1003.001):
```
index=main source="*babyshark*" | stats count by Event.System.EventID
index=main source="*babyshark*" (mimikatz OR sekurlsa OR "Invoke-" OR "-enc")
```
Hunt E - user added to Administrators, Event 4732 (T1098):
```
index=main source="*Guest*" | table _time Event.System.EventID Event.System.Computer Event.EventData.TargetUserName Event.EventData.MemberSid
```

## If a file seems missing
Search every index and every date, in case of odd timestamps:
```
index=* earliest=1 latest=+20y | stats count by index, source
```
