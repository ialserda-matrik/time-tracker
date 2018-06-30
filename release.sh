#!/usr/bin/env bash
# The release process contains of the following two steps;
# 1 The buildnumber is increased and a Git tag is set. This step is performed by this script.
#   You should at least increase the buildnumber before pushing your changes! Otherwise the build pipeline will fail since
#   the deliverables [like the application, stubs and frontend] can only be created once per buildnumber.
#   This to ensure uniqueness.
#
#   Before you release, you must pull the latest changes and check whether you have pending changes via the 'git status' commmand.
#
#   So when you perform a 'git status', then the message 'nothing to commit, working directory clean' should be shown.
#
#   localhost:import-order-batches GJDB$ git status
#   On branch <branch name>
#   Your branch is up-to-date with 'origin/<branch name>'.
#   nothing to commit, working directory clean
#   localhost:import-order-batches GJDB$
# 2 The build pipeline on the buildserver builds based on the latest tagged version.
#   It will build the deliverables and puts then in the Nexus staging repository. These new deliverables [for example
#   the application, stubs and frontend] will be deployed to the teamserver and tested there.
mvn clean validate -Prelease
# mvn clean install -Prelease