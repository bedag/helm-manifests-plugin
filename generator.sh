#!/usr/bin/env sh
# Copyright © 2021 Bedag Informatik AG
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


## -- Help Context
show_help() {
cat << 'EOF'

Usage: ${0##*/} [-h] [ [-m] manifest || [-p] preset ] [-k] parentkey [-P] keypath [-a] helm_args [-M]
    -m [manifest]      Manifest Name
    -p [preset]        Preset Name
    -k [parentkey]     Custom Parent Key
    -P [keypath]       Custom Key Path
    -a [helm args]     Additional Helm Arguments
    -M                 Minimal Structure
    -h                 Show this context

EOF
}

## -- Defaults
MANIFEST=""
PRESET=""
HELM_ARGS=""
KEYPATH=""
MINIMAL=""
PARENTKEY=""

## -- Opting arguments
OPTIND=1; # Reset OPTIND, to clear getopts when used in a prior script
while getopts ":ha:P:k:m:p:k:M" opt; do
  case ${opt} in
    m)
       MANIFEST="${OPTARG}"
       ;;
    p)
       PRESET="${OPTARG}"
       ;;
    k)
       PARENTKEY="${OPTARG}"
       ;;
    P)
       KEYPATH="${OPTARG}"
       ;;
    a)
       HELM_ARGS="${OPTARG}"
       ;;
    M)
       MINIMAL="true"
       ;;
    h)
       show_help
       exit 0
       ;;
    ?)
       echo "Invalid Option: -$OPTARG" 1>&2
       exit 1
       ;;
  esac
done
shift $((OPTIND -1))

## -- Helm Values
HELM_VALUES=""
[ -n "$MANIFEST" ] && HELM_VALUES="--set doc.manifest=${MANIFEST}"
[ -n "$PRESET" ] && HELM_VALUES="${HELM_VALUES} --set doc.preset=${PRESET}"
[ -n "$KEYPATH" ] && HELM_VALUES="${HELM_VALUES} --set doc.path=${KEYPATH}"
[ -n "$PARENTKEY" ] && HELM_VALUES="${HELM_VALUES} --set doc.key=${PARENTKEY}"
[ -n "$MINIMAL" ] && HELM_VALUES="${HELM_VALUES} --set doc.minimal=true"

## -- Execute Helm
$HELM_BIN template $HELM_VALUES ${HELM_ARGS} --dependency-update $HELM_PLUGIN_DIR/values-generator/
