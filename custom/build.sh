#!/usr/bin/env bash
#
# SPDX-License-Identifier: GPL-3.0-or-later

_buildsh_path="$(realpath -- "$0")"
exec mkarchiso -v "$@" "${_buildsh_path%/*}"
