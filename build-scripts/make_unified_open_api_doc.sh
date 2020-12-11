#!/bin/bash

set -e

main() {
  local docs_src="${1:?Missing param docs_src at index 1.}"
  local docs_out="${2:?Missing param docs_out at index 2.}"
  local api_docs="${3:?Missing param api_docs at index 3.}"
  jq '.paths |= $paths' --argfile paths ${docs_src}/paths.json swagger_template.json > ${docs_src}/merged_paths.json
  jq '.definitions |= $defs' --argfile defs ${docs_src}/defs.json ${docs_src}/merged_paths.json > ${docs_out}/code42api.json

  # put the merged file into the directory for publishing
  cp ${docs_out}/code42api.json ${api_docs}
}

main "$@"
