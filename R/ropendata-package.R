#' Query and Download 'Rapid7' Cybersecurity Data Sets
#'
#' 'Rapid7' collects cybersecurity data and makes it available via
#' their 'Open Data' <opendata.rapid7.com> portal which has an 'API'. Tools are
#' provided to assist in querying for available data sets and downloading any
#' data set authorized to a registered account.
#'
#' You will need to request a free account on Open Data via
#' <https://opendata.rapid7.com/#register> and then navigate to the "Open Data API"
#' link there to create both an organizational key and a user key. You can only
#' use **user keys** with the Open Data API and you will receive error messages
#' indicating so if you try to use an organizational key.
#'
#' @md
#' @name ropendata
#' @docType package
#' @author Bob Rudis (bob_rudis@@rapid7.com)
#' @keywords internal
#' @import httr
#' @importFrom utils download.file
#' @importFrom jsonlite fromJSON
NULL
