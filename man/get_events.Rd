% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_events.R
\name{get_events}
\alias{get_events}
\title{Get the events for a continous series of rainfall}
\usage{
get_events(precip = NULL, n_dry = NULL, min_thresh = NULL)
}
\arguments{
\item{precip}{Vector with rainfall-measurements}

\item{n_dry}{= number of hours with rainfall below \code{min_thresh} to separate two
rainfall-events}

\item{min_thresh}{minimum rainfall per hour to be considered rainfall and no measurement error}
}
\description{
Get the events for a continous series of rainfall
}
