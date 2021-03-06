% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/YAMLClass.R
\docType{class}
\name{YAMLClass-class}
\alias{YAMLClass-class}
\alias{YAMLClass}
\title{Query a YAML object for a certain parameter.}
\description{
If the object has the param, then return it.
If the param is unknown, create it with the given default value and return the default.
}
\section{Fields}{

\describe{
\item{\code{yamlObj}}{A Yaml object as created by \code{\link[yaml]{yaml.load}}}
}}

\section{Methods}{

\describe{
\item{\code{getYAML(param_name, default, min = NA, max = NA)}}{Query this YAML object for a certain parameter and return its value. If it does not exist it is created with a default value.
An optional min/max range can be specified and will be enforced if the value is known (default will be used upon violation).}

\item{\code{setYAML(param_name, value)}}{Set a YAML parameter to a certain value. Overwrites the old value or creates a new entry if hithero unknown.}

\item{\code{writeYAML(filename)}}{Write YAML config (including some documentation) to a YAML file. Returns TRUE on success (always), unless writing the file generates an error.}
}}

\examples{
    yc = YAMLClass$new(list())
    val = yc$getYAML("cat$subCat", "someDefault")
    val  ## someDefault
    val = yc$setYAML("cat$subCat", "someValue")
    val  ## someValue
    yc$getYAML("cat$subCat", "someDefault") ## still 'someValue' (since its set already)

}
