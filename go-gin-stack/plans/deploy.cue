package main

import(
  "github.com/h8r-dev/plans/h8r"
)

deploy: h8r.#Deploy & {
  helmPath: "helm"
  releaseName: initRepo.applicationName
  repoUrl: initRepo.gitUrl
  ghcrPassword: initRepo.accessToken
}