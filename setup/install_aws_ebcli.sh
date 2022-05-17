#!/usr/bin/env bash
# vim:ts=4:sts=4:sw=4:et
#
#  Author: Hari Sekhon
#  Date: 2022-05-17 16:02:53 +0100 (Tue, 17 May 2022)
#
#  https://github.com/HariSekhon/DevOps-Bash-tools
#
#  License: see accompanying LICENSE file
#
#  https://www.linkedin.com/in/HariSekhon
#

# Installs Elastic Beanstalk CLI
#
# https://github.com/aws/aws-elastic-beanstalk-cli-setup

set -euo pipefail
[ -n "${DEBUG:-}" ] && set -x
srcdir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# shellcheck disable=SC1090,SC1091
. "$srcdir/../lib/utils.sh"

# shellcheck disable=SC1090,SC1091
. "$srcdir/../lib/ci.sh"

section "Install Elastic Beanstalk CLI"

mkdir -pv ~/github

cd ~/github

if [ -d aws-elastic-beanstalk-cli-setup ]; then
    pushd  aws-elastic-beanstalk-cli-setup
    git pull
    popd
else
    git clone https://github.com/aws/aws-elastic-beanstalk-cli-setup.git
fi

python3="$(type -P python3)"

"$python3" ./aws-elastic-beanstalk-cli-setup/scripts/ebcli_installer.py -p "$python3"

# -p /usr/local/bin/python3 avoids this error:
#
#    Traceback (most recent call last):
#      File "/Library/Python/2.7/site-packages/virtualenv.py", line 37, in <module>
#        import ConfigParser
#    ModuleNotFoundError: No module named 'ConfigParser'
#
#    During handling of the above exception, another exception occurred:
#
#    Traceback (most recent call last):
#      File "/Library/Python/2.7/site-packages/virtualenv.py", line 39, in <module>
#        import configparser as ConfigParser
#      File "/Library/Python/2.7/site-packages/configparser/__init__.py", line 11, in <module>
#        raise ImportError('This package should not be accessible on Python 3. '
#    ImportError: This package should not be accessible on Python 3. Either you are trying to run from the python-future src folder or your installation of python-future is corrupted.
