#!/bin/bash

cd /tmp/jenkins_home
cp -rv . /var/jenkins_home/
$(which jenkins-plugin-cli) --verbose -d /var/jenkins_home/plugins/ -f /tmp/plugin.txt
chown -R jenkins. /var/jenkins_home
echo 2.0 > /var/jenkins_home/jenkins.install.UpgradeWizard.state
