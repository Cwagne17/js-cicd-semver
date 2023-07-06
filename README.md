# Node.js Version Management Example

This is an example of how to manage a project's SemVer in CICD.

This solution was inspired by terraform's versioning strategy which uses a go file to store the version number and have functions.

This implementation will use the package.json file to store the version number and expose the PRE_RELEASE as an environment variable that can be used in CICD.

Using an environment variable allows us to use the same version number in multiple places without having to parse prerelease tag from the package.json file's version. Additionally, this allows for easier configuration in nodemon, and other tools that can configure environment variables.

## Versioning Strategy

This project uses the following versioning strategy:

```bash
# Pre-release versioning
MAJOR.MINOR.PATCH-PRE_RELEASE

# Release versioning
MAJOR.MINOR.PATCH
```

The `MAJOR.MINOR.PATCH` versioning strategy is the same as the [SemVer](https://semver.org/) strategy and *DOES NOT CHANGE UNLESS MERGED INTO MAIN*.

As development continues, the `PRE_RELEASE` version will be incremented.

feature branches, `feature/*` will use `dev` as the `PRE_RELEASE` value for local development. This *DOES NOT* affect the version number in the package.json file or the environment variables in CICD.

develop branch, `develop` will use `dev` as the `PRE_RELEASE` value. When a feature branch is merged into develop the build in CICD will use the `MAJOR.MINOR.PATCH-alpha` version number.

release branches, `release/*` will use `rc` as the `PRE_RELEASE` value. When a release branch is based from develop the build in CICD will use the `MAJOR.MINOR.PATCH-beta` version number.

main branches, `main` will use no `PRE_RELEASE` value. When a release branch is merged into main the build in CICD will use the `MAJOR.MINOR.PATCH` version number.

## Drawbacks of this approach

PRE_RELEASE needs to be set in the environment for this to work effectively. This means that if you are using a tool like nodemon, you will need to set the environment variable in the nodemon.json file.

