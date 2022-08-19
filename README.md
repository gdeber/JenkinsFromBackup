# JenkinsFromBackup
A set of script and compose file for starting Jenkins recovery from backup.

# Files
- backup-jenkins.sh -> script to create jenkins basic backup
- docker-compose.yaml -> docker compose to create two service for restoring backup and to start jenkins
- init.sh -> script to setup files permissions and install all plugins needed

# how it works
docker compose create a jenkins-setup service which copy backup folder to docker volume, changes files owner and finally use jenkins-pluglin-cli to install all the plugins needed.  