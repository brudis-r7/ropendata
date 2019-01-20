#' Retrieve details for a specific Rapid7 Open Data study
#'
#' @md
#' @param study_name A valid study name. This should be a value from the field
#'        `uniqid` in the result from a call to [list_studies()]. Current known,
#'        good values are "`sonar.national_exposure`", "`heisenberg.cowrie`",
#'        "`sonar.atg_10001_tcp`", "`sonar.http`", "`sonar.ssl`", "`sonar.tcp`",
#'        "`sonar.moressl`", "`sonar.rdns_v2`", "`sonar.udp`", "`sonar.cio`",
#'        "`sonar.https`", "`sonar.fdns`", "`sonar.rdns`",  and "`sonar.fdns_v2`".
#' @param rapid7_opendata_api_key Your Rapid7 Open Data API key. The various
#'        API interface function look for this key in `RAPID7_OPENDATA_API_KEY`.
#'        You can manually provide this key and if the function is used interactively
#'        and the key is not found, you will be prompted to enter the key.
#' @return data frame
#' @export
#' @examples
#' try(
#'   get_study_details("sonar.national_exposure"),
#'   silent=TRUE
#' ) -> details
get_study_details <- function(study_name, rapid7_opendata_api_key = rapid7_api_key()) {

  httr::GET(
    url = sprintf(
      "https://us.api.insight.rapid7.com/opendata/studies/%s/", study_name
    ),
    httr::add_headers(
      `X-Api-Key` = rapid7_opendata_api_key
    ),
    httr::user_agent(ROPENDATA_USER_AGENT)
  ) -> res

  out <- httr::content(res, as = "text", encoding = "UTF-8")
  out <- jsonlite::fromJSON(out)

  httr::stop_for_status(res, out$detail)

  fileset <- list(out$sonarfile_set)
  out$sonarfile_set <- NULL

  out <- as.data.frame(out, stringsAsFactors=FALSE)
  out$fileset <- fileset

  class(out) <- c("tbl_df", "tbl", "data.frame")

  out

}
