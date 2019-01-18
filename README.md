
[![Travis build
status](https://travis-ci.org/brudis-r7/ropendata.svg?branch=master)](https://travis-ci.org/brudis-r7/ropendata)
[![Coverage
status](https://codecov.io/gh/brudis-r7/ropendata/branch/master/graph/badge.svg)](https://codecov.io/github/brudis-r7/ropendata?branch=master)
[![CRAN
status](https://www.r-pkg.org/badges/version/ropendata)](https://cran.r-project.org/package=ropendata)

# ropendata

Query and Download ‘Rapid7’ Cybersecurity Data Sets

## Description

‘Rapid7’ collects cybersecurity data and makes it available via their
‘Open Data’ <https://opendata.rapid7.com> portal which has an ‘API’.
Tools are provided to assist in querying for available data sets and
downloading any data set authorized to a registered account.

## More Info

You will need to request a free account on Open Data via
<https://opendata.rapid7.com/#register> and then navigate to the “Open
Data API” link there to create both an organizational key and a user
key. You can only use **user keys** with the Open Data API and you will
receive error messages indicating so if you try to use an organizational
key.

## What’s Inside The Tin

The following functions are implemented:

  - `get_file_details`: Retrieve details for a given file from a
    specific Rapid7 Open Data study
  - `get_study_details`: Retrieve details for a specific Rapid7 Open
    Data study
  - `list_studies`: List available Rapid7 Cybersecurity Studies
  - `rapid7_api_key`: Get or set `RAPID7_OPENDATA_API_KEY` value

## Installation

``` r
devtools::install_github("brudis-r7/ropendata")
```

## Usage

``` r
library(ropendata)
library(tidyverse)

# current verison
packageVersion("ropendata")
```

    ## [1] '0.1.0'

### List Studies

``` r
studies <- list_studies()

studies
```

    ## # A tibble: 13 x 15
    ##    uniqid name  short_desc long_desc study_url study_name study_venue study_bibtext contact_name contact_email
    ##  * <chr>  <chr> <chr>      <chr>     <chr>     <chr>      <chr>       <chr>         <chr>        <chr>        
    ##  1 sonar… SSL … X.509 cer… The data… https://… Project S… Project So… ""            Rapid7 Labs  research@rap…
    ##  2 sonar… TCP … SYN scan … The data… https://… TCP Scans  Project So… ""            Rapid7 Labs  research@rap…
    ##  3 sonar… HTTP… Responses… Ths data… https://… HTTP GET … Project So… ""            Rapid7 Labs  research@rap…
    ##  4 sonar… Nati… Open port… The data… https://… National … Project So… ""            Rapid7 Labs  research@rap…
    ##  5 sonar… Forw… DNS 'ANY'… This dat… https://… Forward D… Project So… ""            Rapid7 Labs  research@rap…
    ##  6 sonar… Crit… The Criti… The curr… http://w… Global Vu… RSA Securi… ""            Rapid7 Labs  research@rap…
    ##  7 sonar… UDP … UDP scan … The data… https://… UDP Scans  Project So… ""            Rapid7 Labs  research@rap…
    ##  8 sonar… HTTP… Responses… This stu… https://… HTTPS GET… Project So… ""            Rapid7 Labs  research@rap…
    ##  9 sonar… Reve… DNS IPv4 … This dat… https://… Reverse D… Project So… ""            Rapid7 Labs  research@rap…
    ## 10 sonar… Forw… DNS 'ANY'… This dat… https://… Forward D… Project So… ""            Rapid7 Labs  research@rap…
    ## 11 sonar… Reve… DNS IPv4 … This dat… https://… Reverse D… Project So… ""            Rapid7 Labs  research@rap…
    ## 12 heise… Rapi… Rapid7 He… This is … https://… Rapid7 He… Rapid7 Hei… ""            Rapid7 Labs  research@rap…
    ## 13 sonar… More… X.509 cer… The data… https://… Project S… Project So… ""            Rapid7 Labs  research@rap…
    ## # … with 5 more variables: organization_name <chr>, organization_website <chr>, created_at <chr>, updated_at <chr>,
    ## #   sonarfile_set <list>

``` r
glimpse(studies)
```

    ## Observations: 13
    ## Variables: 15
    ## $ uniqid               <chr> "sonar.ssl", "sonar.tcp", "sonar.http", "sonar.national_exposure", "sonar.fdns_v2", "son…
    ## $ name                 <chr> "SSL Certificates", "TCP Scans", "HTTP GET Responses", "National Exposure Scans", "Forwa…
    ## $ short_desc           <chr> "X.509 certificate metadata observed when communicating with HTTPS endpoints", "SYN scan…
    ## $ long_desc            <chr> "The dataset contains a collection of metadata related to the net new X.509 certificates…
    ## $ study_url            <chr> "https://github.com/rapid7/sonar/wiki/SSL-Certificates", "https://github.com/rapid7/sona…
    ## $ study_name           <chr> "Project Sonar: IPv4 SSL Certificates", "TCP Scans", "HTTP GET Responses", "National Exp…
    ## $ study_venue          <chr> "Project Sonar", "Project Sonar", "Project Sonar", "Project Sonar", "Project Sonar", "RS…
    ## $ study_bibtext        <chr> "", "", "", "", "", "", "", "", "", "", "", "", ""
    ## $ contact_name         <chr> "Rapid7 Labs", "Rapid7 Labs", "Rapid7 Labs", "Rapid7 Labs", "Rapid7 Labs", "Rapid7 Labs"…
    ## $ contact_email        <chr> "research@rapid7.com", "research@rapid7.com", "research@rapid7.com", "research@rapid7.co…
    ## $ organization_name    <chr> "Rapid7", "Rapid7", "Rapid7", "Rapid7", "Rapid7", "Rapid7", "Rapid7", "Rapid7", "Rapid7"…
    ## $ organization_website <chr> "http://www.rapid7.com", "http://www.rapid7.com/", "http://www.rapid7.com/", "https://gi…
    ## $ created_at           <chr> "2018-06-07", "2018-06-20", "2018-06-19", "2018-06-12", "2018-06-20", "2018-05-15", "201…
    ## $ updated_at           <chr> "2019-01-17", "2019-01-17", "2019-01-17", "2018-08-06", "2019-01-14", "2013-04-01", "201…
    ## $ sonarfile_set        <list> [<"20190117/2019-01-17-1547700154-https_get_5001_names.gz", "20190117/2019-01-17-154770…

### Get Study Details

``` r
glimpse(
  get_study_details("sonar.national_exposure")
)
```

    ## Observations: 1
    ## Variables: 15
    ## $ uniqid               <chr> "sonar.national_exposure"
    ## $ name                 <chr> "National Exposure Scans"
    ## $ short_desc           <chr> "Open port results for Rapid7's National Exposure reports"
    ## $ long_desc            <chr> "The dataset represents the raw data collected that was used in the production of Rapid7…
    ## $ study_url            <chr> "https://github.com/rapid7/data/tree/master/national-exposure"
    ## $ study_name           <chr> "National Exposure Scans"
    ## $ study_venue          <chr> "Project Sonar"
    ## $ study_bibtext        <chr> ""
    ## $ contact_name         <chr> "Rapid7 Labs"
    ## $ contact_email        <chr> "research@rapid7.com"
    ## $ organization_name    <chr> "Rapid7"
    ## $ organization_website <chr> "https://github.com/rapid7/data/tree/master/national-exposure"
    ## $ created_at           <chr> "2018-06-12"
    ## $ updated_at           <chr> "2018-08-06"
    ## $ fileset              <list> [<"2018-04-11-1523483529-nei_2018-udp_sip_5060.csv.gz", "2018-04-02-1522680455-nei_2018…

### Get Details About A Single Study File

``` r
glimpse(
  get_file_details("sonar.fdns_v2", "2018-06-15-1529049662-fdns_aaaa.json.gz")
)
```

    ## Observations: 1
    ## Variables: 4
    ## $ name        <chr> "2018-06-15-1529049662-fdns_aaaa.json.gz"
    ## $ fingerprint <chr> "9056f555bed59640ee5ffeadbeac8175e5873712"
    ## $ size        <int> 570536141
    ## $ updated_at  <chr> "2018-06-17"

## ropendata Metrics

| Lang | \# Files |  (%) | LoC |  (%) | Blank lines |  (%) | \# Lines |  (%) |
| :--- | -------: | ---: | --: | ---: | ----------: | ---: | -------: | ---: |
| R    |        8 | 0.89 |  98 | 0.87 |          39 | 0.58 |      106 | 0.73 |
| Rmd  |        1 | 0.11 |  15 | 0.13 |          28 | 0.42 |       40 | 0.27 |

## Code of Conduct

Please note that the ‘ropendata’ project is released with a [Contributor
Code of Conduct](CODE_OF_CONDUCT.md). By contributing to this project,
you agree to abide by its terms.
