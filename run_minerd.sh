#!/usr/bin/env bash

minerd-aes-ni --help 2>&1 | grep -q 'CPU does not have AES-NI'
HAS_AES_NI=$?

if [[ "$HAS_AES_NI" == 1 ]]; then
  minerd-aes-ni "$@"
else
  minerd "$@"
fi
