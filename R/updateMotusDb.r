#' Ensures that the motus sqlite file is up-to-date to support the current version of the package.
#' Relies on the updateMotusDb.sqlite database in /inst/extdata/ to run the SQL on the basis of date
#' To insert new sql commands, simply create a new record in the sqlite file as follow.
#'   date: date at which the sql update record was added (default current timestamp)
#'   sql: sql string to execute (you should minimize the risk of database errors by using IF EXISTS or DROP as appropriate prior to your command)
#'   descr: description of the update, printed for the user during the update process
#' The function adds a new admInfo table in the motus sqlite file that keeps track of the 
#' date at which the last correction was applied. The updateMotusDb function only exectute
#' sql commands added since the last correction.
#'  
#' This function is called from the z.onLoad function which adds a hook to the ensureDBTables function of the motusClient package.
#' addHook("ensureDBTables", updateMotusDb). I.E., the current function will be called each time that a new motus file is opened
#' (and the ensureDBTables function is accessed).
#'
#' @param rv return value
#' @param src sqlite database source
#' @param projRecv parameter provided by the hook function call, when opening a file built by project ID
#' @param deviceID parameter provided by the hook function call, when opening a file built by receiver ID
#' @export
#' @author Denis Lepage \email{dlepage@@bsc-eoc.org}
#'
#' @return rv

updateMotusDb <- function(rv, src) {

  # Create and fill the admInfo table if it doesn't exist
  DBI::dbExecute(src$con, paste0("CREATE TABLE IF NOT EXISTS admInfo ",
                                 "(key VARCHAR PRIMARY KEY NOT NULL, value VARCHAR)"))
  DBI::dbExecute(src$con, paste0("INSERT OR IGNORE INTO admInfo (key,value) ",
                                 "VALUES('db_version',date('1970-01-01'))"))

  # Get the current src version
  src_version <- dplyr::tbl(src$con, "admInfo") %>%
    dplyr::filter(key == "db_version") %>%
    dplyr::pull(value) %>%
    as.POSIXct(., tz = "UTC")
  
  update_versions <- dplyr::filter(sql_versions, date > src_version) %>%
    dplyr::arrange(date)

  if (nrow(update_versions) > 0) {
    message(sprintf("updateMotusDb started (%d versions updates)", 
                    nrow(update_versions)))
    
    dates <- apply(update_versions, 1, function(row) {
      message(" - ", row["descr"], sep = "")
	  
	    v = unlist(strsplit(row["sql"], ";"))
      l = lapply(v, function(sql) {
        if (sql != "") try(DBI::dbExecute(src$con, sql))
	  	  sql
	    })	
      row["date"]
    })

    if (length(dates) > 0) dt <- dates[length(dates)]

    if (dt > src_version) {
      DBI::dbExecute(src$con, paste0("UPDATE admInfo set value = '",
                                    strftime(dt, "%Y-%m-%d %H:%M:%S"),
                                    "' where key = 'db_version'"))
    }
  }

  rv
}
