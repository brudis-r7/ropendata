#' Retrieve details for a given file from a specific Rapid7 Open Data study
#'
#' @md
#' @param study_name A valid study name. This should be a value from the field
#'        `uniqid` in the result from a call to [list_studies()]. Current known,
#'        good values are "`sonar.national_exposure`", "`heisenberg.cowrie`",
#'        "`sonar.atg_10001_tcp`", "`sonar.http`", "`sonar.ssl`", "`sonar.tcp`",
#'        "`sonar.moressl`", "`sonar.rdns_v2`", "`sonar.udp`", "`sonar.cio`",
#'        "`sonar.https`", "`sonar.fdns`", "`sonar.rdns`",  and "`sonar.fdns_v2`".
#' @param file_name A valid file name from a given `study_name`.
#' @param include_download_link if `TRUE`, have the API generate a download link
#'        along with the metadata and include it in a `url` field in the data frame.
#'        **NOTE** that **each use** of the this parameter counts towards the Rapid7
#'        Open Data daily download quota. For that reason, the default value is
#'        `FALSE`. Only set it to `TRUE` if you intend to start a download action
#'         (e.g. using [utils::download.file()] with the result) shortly after
#'         calling the function.
#' @param rapid7_opendata_api_key Your Rapid7 Open Data API key. The various
#'        API interface function look for this key in `RAPID7_OPENDATA_API_KEY`.
#'        You can manually provide this key and if the function is used interactively
#'        and the key is not found, you will be prompted to enter the key.
#' @return data frame
#' @export
#' @examples
#' try(
#'   get_file_details("sonar.fdns_v2", "2018-06-15-1529049662-fdns_aaaa.json.gz"),
#'   silent=TRUE
#' ) -> details
get_file_details <- function(study_name, file_name, include_download_link = FALSE,
                             rapid7_opendata_api_key = rapid7_api_key()) {

  httr::GET(
    url = sprintf(
      "https://us.api.insight.rapid7.com/opendata/studies/%s/%s/", study_name, file_name
    ),
    httr::add_headers(
      `X-Api-Key` = rapid7_opendata_api_key
    ),
    httr::user_agent(ROPENDATA_USER_AGENT)
  ) -> res

  out <- httr::content(res, as = "text", encoding = "UTF-8")
  out <- jsonlite::fromJSON(out)

  httr::stop_for_status(res, out$detail)

  out <- as.data.frame(out, stringsAsFactors=FALSE)

  if (include_download_link) {

    httr::GET(
      url = sprintf(
        "https://us.api.insight.rapid7.com/opendata/studies/%s/%s/download/", study_name, file_name
      ),
      httr::add_headers(
        `X-Api-Key` = rapid7_opendata_api_key
      ),
      httr::user_agent(ROPENDATA_USER_AGENT)
    ) -> res2

    out2 <- httr::content(res2, as = "text", encoding = "UTF-8")
    out2 <- jsonlite::fromJSON(out2)

    httr::warn_for_status(res, out$detail)

    if (httr::status_code(res2) == 200) out$url <- out2$url

  }

  class(out) <- c("tbl_df", "tbl", "data.frame")

  out

}
