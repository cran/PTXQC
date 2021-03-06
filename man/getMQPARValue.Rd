% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/fcn_mqpar.R
\name{getMQPARValue}
\alias{getMQPARValue}
\title{Retrieve a parameter value from a mqpar.xml file}
\usage{
getMQPARValue(mqpar_filename, param_name)
}
\arguments{
\item{mqpar_filename}{Filename (incl. absolute or relative path) to the mqpar.xml file}

\item{param_name}{XML tag name, e.g. 'firstSearchTol' from which to read the value}
}
\value{
The stored value as string(!)
}
\description{
If the file has the param, then return it as string.
If the file is missing, warning is shown and NULL is returned.
If the param (i.e. XML tag) is unknown or cannot be extracted, the program will quit (since this is a hard error).
When multiple occurrences of the param are found (usually due to parameter groups), we test if the values are all identical.
If so, the value is returned. If the values are different, a warning is emitted and NULL is returned.
}
\details{
E.g. calling getMQPARValue("mqpar.xml", "firstSearchTol")
will look up the line
<firstSearchTol>20</firstSearchTol>
and return "20" (string!).
}
