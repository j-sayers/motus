<!-- badges: start -->
[![Build status](https://ci.appveyor.com/api/projects/status/d33qyiunqjexdepy?svg=true)](https://ci.appveyor.com/project/steffilazerte/motus)
[![Travis build status](https://travis-ci.org/MotusWTS/motus.svg?branch=master)](https://travis-ci.org/MotusWTS/motus)
[![Codecov test coverage](https://codecov.io/gh/MotusWTS/motus/branch/master/graph/badge.svg)](https://codecov.io/gh/MotusWTS/motus?branch=master)
[![R build status](https://github.com/MotusWTS/motus/workflows/R-CMD-check/badge.svg)](https://github.com/MotusWTS/motus/actions)
<!-- badges: end -->

# motus
R package for users of data from https://motus.org

See the [Motus R book](https://motus.org/MotusRBook/) for detailed usage information


## Installation

### Updating

If you are updating your version of `motus` from a version <1.5.0 to >= 1.5.0 (i.e. from when `motusClient` was a separate package), you will have best results if you first remove `motus` and `motusClient` and reinstall from scratch:

```R
remove.packages(c("motus", "motusClient"))
```

Now you can install v1.5.0+ as follows.

### New Installation

**Users**: the 'master' branch is what you want.  You can install it
from R by doing:
```R
install.packages("remotes")              ## if you haven't already done this
remotes::install_github("motusWTS/motus@master")   ## the lastest stable version
```

**Developers**: the 'betaX' branches are for work-in-progress.  Install the one you want
```R
install.packages("remotes")                       ## if you haven't already done this
remotes::install_github("motusWTS/motus@beta3")   ## the beta branch for version 3+
```

### Troubleshooting

#### General Problems

Many, *many*, problems arise from conflicts between R packages which may be out of date. 
If you have a problem that you can't seem to resolve, try the following steps in order (stopping when the problem goes away). 
If you have a problem installing `motus`, try Step 2 first.

1. Update `motus` and packages that `motus` depends on. (You may first need to install the `remotes` package). **Re-start R**

```R
remotes::update_packages("motus")
```

2. Update all your packages. **Re-start R**

```R
remotes::update_packages()
```

3. Update R <https://cran.r-project.org/>. (You may have to reinstall packages)


#### Specific Problems 

Some known installation problems are listed below. If all else fails, uninstalling R and/or R Studio, and reinstalling the latest R version typically works. Depending on how much customization you have made to your R configuration, this may be the quickest option available.

**cannot remove prior installation of package**

If you get errors "cannot remove prior installation of package ..." (e.g. `dplyr`) while trying to install motus, this could be due to having multiple R sessions active. You can try the following:

1. find out your R package library location: `Sys.getenv("R_LIBS_USER")` or `.libPaths()`
2. close any session of R and/or R Studio
3. in the library folder, manually delete the package that failed to remove (e.g. `dplyr`)
4. restart R and manually install the package again e.g. `install.packages("dplyr")`

Another possible cause of this problem relates to file permissions in your library folders (e.g. libraries installed in c:\program files\R\R-3.x.x\library\). To confirm this, you can try running R "as administrator" (right-clicking the R icon), or use `SUDO R`  (Linux/Ubuntu) and trying installation again. If this resolves your problem, you should consider setting your libraries in a new folder where your logged in user has full access:

```R
# confirm the libPaths location(s)
.libPaths()
# add a new libPaths default location
.libPaths("c:/users/myusername/R/win-libraries")
```

**certificate errors**

If you get a certificate error using the `tagme()` function, please ensure that your `httr` package is up-to-date, as there was a problem reported with one of the recent version that now appears fixed:

```R
remotes::install_github("r-lib/httr")
```
