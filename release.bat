@rem The release process contains of the following two steps;
@rem 1 The buildnumber is increased and a Git tag is set. This step is performed by this script.
@rem   You should at least increase the buildnumber before pushing your changes! Otherwise the build pipeline will fail since
@rem   the deliverables [like the application, stubs and frontend] can only be created once per buildnumber.
@rem   This to ensure uniqueness.
@rem
@rem   Before you release, you must pull the latest changes and check whether you have pending changes via the 'git status' commmand.
@rem
@rem   So when you perform a 'git status', then the message 'nothing to commit, working directory clean' should be shown.
@rem
@rem   localhost:import-order-batches GJDB$ git status
@rem   On branch <branch name>
@rem   Your branch is up-to-date with 'origin/<branch name>'.
@rem   nothing to commit, working directory clean
@rem   localhost:import-order-batches GJDB$
@rem 2 The build pipeline on the buildserver builds based on the latest tagged version.
@rem   It will build the deliverables and puts then in the Nexus staging repository. These new deliverables [for example
@rem   the application, stubs and frontend] will be deployed to the teamserver and tested there.
set /P documentationUpdated=Did you update the release documentation [Y/N]?
if /I NOT "%documentationUpdated%"=="Y" goto error

call mvn clean validate -Prelease

if not %ERROR_CODE%==0 goto error
    for /F "eol=; tokens=2,2 delims==" %%i IN ('findstr /i "buildNumber" buildNumber.properties') do set buildNumber=%%i
    for /f "tokens=2-4delims=<>" %%a in (pom.xml) do (
    IF "%%a"=="major.version" IF "%%c"=="/major.version" set major=%%b
    )
    for /f "tokens=2-4delims=<>" %%a in (pom.xml) do (
    IF "%%a"=="minor.version" IF "%%c"=="/minor.version" set minor=%%b
    )

    call git commit -a -m "Upgrade build number to %major%.%minor%-b%buildNumber%"
    call mvn clean validate -Ptag
    call git push --follow-tags
goto end

:error
echo Validating the release failed

:end
