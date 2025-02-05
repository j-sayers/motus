% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/tagme.R
\name{tagme}
\alias{tagme}
\title{Download motus tag detections to a database}
\usage{
tagme(
  projRecv,
  update = TRUE,
  new = FALSE,
  dir = getwd(),
  countOnly = FALSE,
  forceMeta = FALSE,
  rename = FALSE,
  skipActivity = FALSE,
  skipNodes = FALSE
)
}
\arguments{
\item{projRecv}{integer. Project code from motus.org, \emph{or} character
scalar receiver serial number}

\item{update}{logical. Should any new data be downloaded and merged?
Defaults to TRUE unless this is a new database (in which case you must
specify \code{update = TRUE} explicitly).}

\item{new}{logical. Is this a new database?  Default: FALSE You have to
specify \code{new = TRUE} if you want a new local copy of the database to be
created. Otherwise, \code{tagme()} assumes the database already exists,
and will stop with an error if it cannot find it in the current directory.
This is mainly to prevent inadvertent downloads of large amounts of data
that you already have!}

\item{dir}{character. Path to the folder where you are storing databases
Defaults to current directory; i.e. \code{getwd()}.}

\item{countOnly}{logical. If FALSE, the default, then do requested
database updates. Otherwise, return a count of items that would need to be
transferred in order to update the database.}

\item{forceMeta}{logical. If TRUE, re-get metadata for tags and receivers,
even if we already have them.}

\item{rename}{logical. If current SQLite database is of an older version,
automatically rename that database for backup purposes and download the
newest version. If FALSE (default), user is prompted for action.}

\item{skipActivity}{logical. Skip checking for and downloading \code{activity}? See
\code{?activity} for more details}

\item{skipNodes}{logical. Skip checking for and downloading \code{nodeData}? See
\code{?nodeData} for more details}
}
\value{
a dplyr::src_sqlite for the (possibly updated) database, or a list
of counts if \code{countOnly==TRUE}
}
\description{
Download motus tag detections to a database
}
\examples{

## create and open a local tag database for motus project 14 in the
## current directory

# t = tagme(14, new=TRUE)

## update and open the local tag database for motus project 14;
## it must already exist and be in the current directory

# t = tagme(14, update=TRUE)

## update and open the local tag database for a receiver;
## it must already exist and be in the current directory

# t = tagme("SG-1234BBBK4567", update=TRUE)

## open the local tag database for a receiver, without
## updating it

# t = tagme("SG-1234BBBK4567")

## open the local tag database for a receiver, but
## tell 'tagme' that it is in a specific directory

# t = tagme("SG-1234BBBK4567", dir="Projects/gulls")

## update all existing project and receiver databases in \code{dir}
# tagme()

}
\seealso{
\code{\link{tellme}}, which is a synonym for \code{tagme(..., update=TRUE, countOnly=TRUE)}
}
