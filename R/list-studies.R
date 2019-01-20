#' List available Rapid7 Cybersecurity Studies
#'
#' @md
#' @param rapid7_opendata_api_key Your Rapid7 Open Data API key. The various
#'        API interface function look for this key in `RAPID7_OPENDATA_API_KEY`.
#'        You can manually provide this key and if the function is used interactively
#'        and the key is not found, you will be prompted to enter the key.
#' @return data frame
#' @export
#' @examples
#' try(
#'   list_studies(), silent=TRUE
#' ) -> studies
list_studies <- function(rapid7_opendata_api_key = rapid7_api_key()) {

  httr::GET(
    url = "https://us.api.insight.rapid7.com/opendata/studies/",
    httr::add_headers(
      `X-Api-Key` = rapid7_opendata_api_key
    ),
    httr::user_agent(ROPENDATA_USER_AGENT)
  ) -> res

  out <- httr::content(res, as = "text", encoding = "UTF-8")
  out <- jsonlite::fromJSON(out)

  httr::stop_for_status(res, out$detail)

  class(out) <- c("tbl_df", "tbl", "data.frame")

  out

}