#!/usr/bin/env bash

set -e
# Setup jenkins home dir
JENKINS_HOME="/var/lib/jenkins"
JENKINS_JOBS_DIR="${JENKINS_HOME}/jobs/"
BCK_BASE_DIR="./backup$(date '+%Y%m%d')/"
mkdir -p $BCK_BASE_DIR

#copy all .xml
cp "${JENKINS_HOME}"/*.xml "${BCK_BASE_DIR}"

#copy secrets
cp "${JENKINS_HOME}"/secret.key* "${BCK_BASE_DIR}"
cp "${JENKINS_HOME}/identity.key.enc" "${BCK_BASE_DIR}"
cp -r "${JENKINS_HOME}/secrets" "${BCK_BASE_DIR}"

#copy other folders
cp -r "${JENKINS_HOME}/init.groovy.d" "${BCK_BASE_DIR}"
cp -r "${JENKINS_HOME}/nodes" "${BCK_BASE_DIR}"
cp -r "${JENKINS_HOME}/users" "${BCK_BASE_DIR}"
cp -r "${JENKINS_HOME}/userContent" "${BCK_BASE_DIR}"


#backup jobs config
for job_dir in ${JENKINS_JOBS_DIR}*; do
	if [ -d "$job_dir" ]; then
		if [ -f "${job_dir}/config.xml" ]
		then
			DEST_DIR="${BCK_BASE_DIR}/jobs/${job_dir##*/}"
			mkdir -p "${DEST_DIR}"
			cp "${job_dir}/config.xml" "${DEST_DIR}"
			test -f "${job_dir}/nextBuildNumber" && cp "${job_dir}/nextBuildNumber" "${DEST_DIR}"
		fi
	fi
done
