# Running GitHub Actions Workflows

This repository uses **GitHub Actions** to automate common tasks such as:
- Validating code
- Running tests
- Building artifacts
- Deploying infrastructure or applications

This document explains **what GitHub Actions are**, **how our workflows run**, and **how you can manually trigger and troubleshoot them**.

---

## What Are GitHub Actions?

GitHub Actions is GitHub’s **built-in CI/CD (Continuous Integration / Continuous Delivery)** platform.

It allows you to:
- Automatically run jobs when code changes
- Enforce standards and quality checks
- Deploy infrastructure and applications
- Reduce manual, error-prone work

All workflows are defined as **YAML files** inside the repository.

---

## Where Workflows Live

GitHub Actions workflows are stored in:

```
.github/workflows/
```

## How Workflows Are Triggered

Workflows can run in multiple ways depending on configuration.

Automatic Triggers

Most workflows run automatically when certain events occur, such as:

Pushing code to a branch

Opening or updating a pull request

Merging into main

Creating a tag or release

```
on:
  push:
    branches: [ main ]
  pull_request:
```

Manual Triggers (Recommended for Training & Testing)

Some workflows support manual execution using the GitHub UI.

These workflows include:

```
on:
  workflow_dispatch:
```

How to Manually Run a Workflow

Go to the GitHub repository

Click the Actions tab

Select the workflow you want to run

Click Run workflow

Choose:

Branch

Input parameters (if applicable)

Click Run workflow

The workflow will start immediately.

Viewing Workflow Runs

To view workflow execution details:

Go to the Actions tab

Click a workflow run

Select a job

Expand individual steps to view logs

Logs show:

Commands that were run

Output from tools

Errors and warnings

## Understanding Workflow Structure

A typical workflow contains:

```
name: Example Workflow

on:
  push:
    branches: [ main ]

jobs:
  example-job:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Run a script
        run: echo "Hello, world!"
```

| Component | Description                    |
| --------- | ------------------------------ |
| `on`      | Defines when the workflow runs |
| `jobs`    | One or more independent jobs   |
| `runs-on` | GitHub-hosted runner OS        |
| `steps`   | Individual commands or actions |

## Required Permissions

Some workflows require:

Repository write access

Secrets

Environment approvals

If a workflow fails immediately, check:

Your GitHub permissions

Whether required secrets exist

## Secrets and Variables

Sensitive values are stored securely in GitHub.

## Repository Secrets

API keys

Tokens

Passwords

Configured under:

Settings → Secrets and variables → Actions

Workflows reference secrets like:

```
${{ secrets.MY_SECRET }}
```

## Common Workflow Failures & Fixes
Authentication Errors

Missing or expired tokens

Incorrect secret names

Insufficient permissions

Tool Not Found

Tool not installed on runner

Wrong version specified

Permission Denied

Repository access issue

Environment protection rules

YAML Syntax Errors

Incorrect indentation

Missing colons or fields

Canceling or Re-Running a Workflow
Cancel a Run

Open the workflow run

Click Cancel workflow

Re-Run

Open a completed run

Click Re-run jobs or Re-run all jobs

## Best Practices

✔ Always review logs when a workflow fails
✔ Use pull requests to validate changes
✔ Keep workflows small and readable
✔ Store secrets securely
✔ Avoid hardcoding credentials

## Frequently Asked Questions
Do I need to install anything locally?

No. GitHub Actions runs on GitHub-hosted runners.

Can I run workflows from forks?

Only if permissions allow and secrets are accessible.

Are workflows free?

GitHub provides free minutes for public repositories and limited free minutes for private repos.

## Summary

GitHub Actions enables:

Automated testing

Safer deployments

Consistent builds

Faster feedback

Understanding how workflows run and how to read logs is essential for working in modern DevOps and DevSecOps environments.