# terra-cloud

Terraform lab: provisions a small AWS resource (SSM parameter) with state stored in HCP Terraform.
CI runs in GitHub Actions.

## Architecture

- `terraform.tf`: `cloud {}` block (org `GamoroLearn`, workspace `tf-all`), AWS provider, `allowed_account_ids` guard.
- `aws.tf`: `aws_caller_identity` data source and the SSM parameter.
- `outputs.tf`: outputs.
- `.github/workflows/terraform.yml`: fmt, init, validate, plan on PR/push; apply on push to `main`.

## Decisions

- **State in HCP Terraform, CLI-driven workflow.** Central state, locking and history. Alternative: S3 backend (more setup).
- **No `profile` in the provider.** A profile exists only on one machine and breaks CI and remote runs. Locally use `export AWS_PROFILE=atnt`.
- **`allowed_account_ids` pinned.** Stops a run that has credentials for the wrong AWS account.
- **HCP provider removed.** It was only used for HCP Vault Secrets; the `HCP_CLIENT_*` service principal is not needed now. The old workspace `HCPVaultSecretsLab` and its key should be deleted/revoked in HCP.
- **CI gets AWS credentials via GitHub OIDC**, assuming role `terraform-all-ssm-lab` (no static keys). The workspace runs in Local mode, so the runner executes plan/apply and needs the credentials. The role's trust policy is limited to `repo:atnguyentr/terraform-all:*`; its permissions are limited to SSM parameters under `/terra-cloud-lab/*`.
- **CI authenticates to HCP Terraform with a Team API token** (`TF_API_TOKEN` secret), not `terraform login`.

## Local use

```
export AWS_PROFILE=atnt
aws sts get-caller-identity
terraform init && terraform plan
```

## Progress

- Done: HCP config removed, outputs split out, CI workflow written.
- Not verified yet: first CI run, and where AWS credentials live for the `tf-all` workspace (Remote needs them in the workspace, e.g. OIDC; Local needs them on the runner).
- Next: create the Team token and `TF_API_TOKEN` secret, push to GitHub, open a PR and check the `plan`.
