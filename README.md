# Detection-as-Code-CI-CD-Pipeline

This repository houses an automated Detection-as-Code (DaC) pipeline designed to validate and deploy security detection rules directly into RunReveal. By treating security alerts like software code, this pipeline ensures that all detections are peer-reviewed, version-controlled, and thoroughly tested against sample logs before protecting the live environment.

## Project Structure

The repository is purposefully organized to separate rule types, automated workflows, and testing artifacts:

*   `.github/workflows/validate.yml`: The continuous integration (CI) workflow that automatically lints and dry-runs new rules when a Pull Request is opened.
*   `.github/workflows/deploy.yml`: The continuous deployment (CD) workflow that permanently syncs approved rules to the live RunReveal workspace upon merging to the main branch.
*   `sigma/`: Contains YAML-based Sigma rules, such as `SSH Brute Force Detection.yml`, for standardized threat detection.
*   `sql/`: Houses advanced SQL queries and their associated schedule/notification YAML configurations, such as `ssh_brute_force.sql` and `ssh_brute_force.yaml`.
*   `samples/`: Stores synthetic test data, including `badguy.json`, to validate rule logic against simulated attacker behavior.

## Automated Workflows

The CI/CD framework completely removes the need for manual dashboard configurations, operating headlessly through the RunReveal CLI. When a new detection is submitted:

1.  The **Validation** workflow securely authenticates using hidden repository secrets (`RUNREVEAL_WORKSPACE` and `RUNREVEAL_TOKEN`).
2.  It executes a strict syntax check (linting) across both the `sigma/` and `sql/` directories.
3.  A dress-rehearsal dry-run ensures the rule logic integrates perfectly without crashing the live environment.
4.  Once peer-reviewed and merged, the **Deployment** workflow pushes the active rules directly to RunReveal, automatically wiring them to your designated notification channels.
