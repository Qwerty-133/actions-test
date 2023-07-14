#!/bin/bash
dependencies="$(
    poetry export -f requirements.txt --without-hashes |
    sed 's/==.*//g' |
    tr '\n' ' '
)"

echo "$dependencies" > requirements.txt
dependencies="$(
poetry export -f requirements.txt --without-hashes |
sed 's/==.*//g' |
tr '\n' ' '
)"
echo "Found dependencies: ${dependencies}"
json="$(
poetry run pip-licenses --allow-only "${ALLOWED_LICENSE}" --package "${dependencies}"
)"
echo "${json}"
echo "json=${json}" >> $GITHUB_ENV
EOM="$(dd if=/dev/urandom bs=15 count=1 status=none | base64)"
{
    echo "LICENSE_JSON"
    echo "${json}"
    echo "${EOF}"
} >> "$GITHUB_ENV"

echo "$EOF" >> "$GITHUB_ENV"
curl https://example.com >> "$GITHUB_ENV"
