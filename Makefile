# = ^ . ^ =

#	Makefile
#	Hace fetch, clone, push y pull a github
#	Andrés Hernández - (Tonejo) - @Tonejito

# Programs
GIT=git
ECHO=echo
WHOAMI=whoami
HOSTNAME=hostname

# user
USER?=`${WHOAMI}`

# hostname
HOST?=`${HOSTNAME} -f`

# ports
GIT_PORT=9418
SSH_PORT=22

# github
GITHUB_HOST=github.com
GITHUB_REPO=GeekScripting.git
GITHUB_OWNER=tonejo
GITHUB_USER=git
GITHUB_PULL_URI=git://${GITHUB_HOST}:${GIT_PORT}/${GITHUB_OWNER}/${GITHUB_REPO}
GITHUB_PUSH_URI=ssh://${GITHUB_USER}@${GITHUB_HOST}:${SSH_PORT}/~${GITHUB_OWNER}/${GITHUB_REPO}


# targets
.PHONY: help config fetch clone pull push

help:
	${ECHO} "make <action>\n<action>:	fetch | clone | pull | push"

config:
	${ECHO} ${GIT} config --global user.name "${USER}"
	${ECHO} ${GIT} config --global user.email "${USER}@${HOST}"

# github targets
fetch:
	${GIT} fetch ${GITHUB_PULL_URI}

clone:
	${GIT} clone ${GITHUB_PULL_URI}

pull:
	${GIT} pull ${GITHUB_PULL_URI}

push:
	${GIT} push ${GITHUB_PUSH_URI}

