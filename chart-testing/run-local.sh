#!/bin/sh

changed="$(ct list-changed --target-branch main)"
targetBranch="$(git branch --show-current)"
ct lint-and-install \
  --target-branch="${targetBranch}" \
  --charts="${changed}" \
  --validate-chart-schema=false \
  --lint-conf="chart-testing/lintconf.yaml"
