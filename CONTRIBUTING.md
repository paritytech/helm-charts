# Contributing Guidelines

Contributions are welcome via GitHub Pull Requests. This document outlines the process to help get your contribution accepted.

Any type of contribution is welcome; from new features, bug fixes, tests, documentation improvements, or even adding charts to the repository.

## How to Contribute

1. Fork this repository, develop, and test your changes.
2. Submit a pull request.

***NOTE***: To make the Pull Requests' (PRs) testing and merging process easier, please submit changes to multiple charts in separate PRs.

Remember to always work in a branch of your local copy, as you might otherwise have to contend with conflicts in the main branch.

### Technical Requirements

When submitting a PR make sure that:

- You accepted the [CLA](https://colineberhardt.github.io/cla-bot/#what-is-a-cla);
- Your PR passes CI jobs for linting and tests (automatically done by the CI pipeline);
- Your PR follows [Helm best practices](https://helm.sh/docs/chart_best_practices/);
- Any change (even if it only updates the docs) to a chart leads to a version bump following [semver](https://semver.org/) principles. This is the version that is going to be merged in the GitHub repository and published to the Helm registry. Update the version in the `Chart.yaml` file.

### Documentation Requirements

- Make sure to properly annotate each parameter you add/update in the `values.yaml` file. The table of parameters is generated based on these annotations from the `values.yaml` file using [helm-docs](https://github.com/norwoodj/helm-docs);
- Do NOT edit `README.md` directly. Instead make changes to `README.md.gotmpl`. `README.md` will be auto-generated as part of pre-commit hooks.

### Pre-commit Hooks
This repository is using `pre-commit` hooks which are executed using [pre-commit](https://pre-commit.com/). Pre-commit hooks allow to execute scripts on the local developer's machine before committing the changes to the repository. We're using `pre-commit` hooks to auto-generate `REAMDE.md` based on the templates. For example, check out [Node Helm chart README.md](charts/node/README.md.gotmpl)

Follow the [instructions](https://pre-commit.com/#install) to install `pre-commit`. `REAMDE.md` will be updating automatically after that.

To manually render `README.md`, you should install [`helm-docs`](https://github.com/norwoodj/helm-docs), navigate to repository root and run:
```
helm-docs --chart-search-root=charts/<CHART_NAME> --template-files=README.md.gotmpl
```

You may encounter `files were modified by this hook` error after updating `README.md.gotmpl` file when using `pre-commit`.
This is intended behaviour. Make sure to run `git add -A` once again to stage changes in the auto-updated `REAMDE.md`
