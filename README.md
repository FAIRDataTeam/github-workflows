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

## Examples

### maven-publish

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
      mvn_options:  -Dgpg.skip tidy:check com.github.spotbugs:spotbugs-maven-plugin:check
```

### maven-verify with database

The maven-verify workflow also supports optional database setup. For example:

```yaml
jobs:
  test:
    uses: FAIRDataTeam/github-workflows/.github/workflows/maven-verify.yml@v2
    with:
      # the double quotes are required for windows runners
      mvn-options: '-D"spring.profiles.active"=testing'
      # db settings must match those defined in the spring profile
      db-type: postgresql
      db-name: fdp_test
      db-username: fdp
      db-password: fdp
      db-port: 54321
```

### docker-publish
For pull requests, nothing is uploaded, but a test build is created.

The following variables and secrets must be defined in the calling repo (conforming to existing names from the FDP repos):
 
- `vars.DOCKER_IMAGE_NAME`
- `vars.DOCKER_HUB_USERNAME`
- `secrets.DOCKER_HUB_PASSWORD`

Secrets must be inherited from the caller.

The workflow could be triggered on `push` and `pull_request` (see [1]). For example:

```yaml
name: publish to docker hub on push
on:
  push:
    branches:
      - develop
  pull_request:

jobs:
  publish:
    uses: FAIRDataTeam/github-workflows/.github/workflows/docker-publish.yml@v1
    secrets: inherit
    with:
      push: ${{ github.event_name != 'pull_request' }}
```

Alternatively, we could push on release creation only, for example:

```yaml
name: publish to docker hub on release
on:
  release:
    types: [created]

jobs:
  publish:
    uses: FAIRDataTeam/github-workflows/.github/workflows/docker-publish.yml@v1
    secrets: inherit
    with:
      push: ${{ github.event_name == 'release' && github.event.action == 'created' }}
```

## Releases

Releases follow [semantic versioning]. 
To get the latest stable release you can refer to the major version only, e.g. `v1` instead of `v1.2.3`.
Also see [action versioning].

>[!NOTE]
> 
>Contributors, please read the [contribution guidelines] for instructions w.r.t. releases.

[action versioning]: https://github.com/actions/toolkit/blob/master/docs/action-versioning.md#recommendations
[avoiding-duplication]: https://docs.github.com/en/actions/sharing-automations/avoiding-duplication
[contribution guidelines]: ./CONTRIBUTING
[reusing-workflows]: https://docs.github.com/en/actions/sharing-automations/reusing-workflows
[semantic versioning]: https://semver.org/
[sharing automations]: https://docs.github.com/en/actions/sharing-automations
[sharing-actions-and-workflows-with-your-organization]: https://docs.github.com/en/actions/sharing-automations/sharing-actions-and-workflows-with-your-organization

[FAIRDataTeam]: https://github.com/FAIRDataTeam
[rdf-resource-resolver]: https://github.com/FAIRDataTeam/rdf-resource-resolver
[spring-rdf-migration]: https://github.com/FAIRDataTeam/spring-rdf-migration
[spring-security-acl-mongodb]: https://github.com/FAIRDataTeam/spring-security-acl-mongodb
