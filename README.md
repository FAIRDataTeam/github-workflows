# github-workflows

Reusable github workflows for FAIRDataTeam repositories.

## General info

For more info about reusing workflows, see [sharing automations] documentation, specifically:
- [avoiding-duplication]
- [reusing-workflows]
- [sharing-actions-and-workflows-with-your-organization]

## Dependent repos

The following [FAIRDataTeam] repositories depend on the reusable workflows from this repo:

- [rdf-resource-resolver]
- [spring-rdf-migration]
- [spring-security-acl-mongodb]

## Example

An example of a publication workflow that is triggered when a release is created, and re-uses two workflows:

```yaml
name: Maven publish
on:
  release:
    types: [created]
jobs:
  test:
    uses: FAIRDataTeam/github-workflows/.github/workflows/maven-verify.yml@v1
  publish:
    needs: test
    uses: FAIRDataTeam/github-workflows/.github/workflows/maven-publish.yml@v1
    secrets: inherit
```

It is also possible to specify additional options for the maven-verify workflow, for example:

```yaml
jobs:
  test:
    uses: FAIRDataTeam/github-workflows/.github/workflows/maven-verify.yml@v1
    with:
      mvn_options: tidy:check com.github.spotbugs:spotbugs-maven-plugin:check
```

## Releases

Releases follow [semantic versioning]. 
To get the latest stable release you can refer to the major version only, e.g. `v1` instead of `v1.2.3`.
Also see [action versioning].

[action versioning]: https://github.com/actions/toolkit/blob/master/docs/action-versioning.md#recommendations
[avoiding-duplication]: https://docs.github.com/en/actions/sharing-automations/avoiding-duplication
[reusing-workflows]: https://docs.github.com/en/actions/sharing-automations/reusing-workflows
[semantic versioning]: https://semver.org/
[sharing automations]: https://docs.github.com/en/actions/sharing-automations
[sharing-actions-and-workflows-with-your-organization]: https://docs.github.com/en/actions/sharing-automations/sharing-actions-and-workflows-with-your-organization

[FAIRDataTeam]: https://github.com/FAIRDataTeam
[rdf-resource-resolver]: https://github.com/FAIRDataTeam/rdf-resource-resolver
[spring-rdf-migration]: https://github.com/FAIRDataTeam/spring-rdf-migration
[spring-security-acl-mongodb]: https://github.com/FAIRDataTeam/spring-security-acl-mongodb
