// The version package provides a location to set the release versions for all
// packages to consume.

// The main version number that is being run at the moment.
const Version = require('./package.json').version;

// A pre-release marker for the version. If this is "" (empty string)
// then it means that it is a final release. Otherwise, this is a pre-release
// such as "dev" (in development), "beta", "rc1", etc.
const Prerelease = process.env.PRE_RELEASE;

// The semantic version of the release.
const SemVer = Version + (Prerelease ? '-' + Prerelease : '')

// Print the version to the console.
console.log(SemVer);

module.exports = { SemVer: SemVer }
