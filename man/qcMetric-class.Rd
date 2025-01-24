% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/qcMetric.R
\docType{class}
\name{qcMetric-class}
\alias{qcMetric-class}
\alias{qcMetric}
\title{Class which can compute plots and generate mzQC output (usually for a single metric).}
\arguments{
\item{df}{The expected data, usually a data frame. If empty, this function will return immediately without failure.}

\item{...}{Additional arguments passed to the workerFcn()}
}
\description{
Internally calls the workerFcn() , which computes the actual plots metric scores and supporting data (e.g. mzQC metrics) of the derived class; the resulting data is checked and stored in the members of this class
}
\details{
Reference class which is instanciated with a metric description and a
worker function (at initialization time, i.e. in the package)
and can produce plots and mzQC values (at runtime, when data is provided) using setData().

All derived classes need to implement a 'workerFcn()' function, which returns a list with
elements: c("plots", "mzQC", "htmlTable", "qcScores", "title"),
where 'plots' is required; all others are optional.
}
\section{Fields}{

\describe{
\item{\code{helpText}}{Description (lengthy) of the metric and plot elements}

\item{\code{workerFcn}}{Function which generates a result (usually plots). Data is provided using setData().}

\item{\code{plots}}{List of plots (after setData() was called)}

\item{\code{htmlTable}}{A table for display in the HTML report (preferred over a plot in Html mode)}

\item{\code{qcScores}}{Data.frame of scores from a qcMetric (computed within workerFcn())}

\item{\code{mzQC}}{An named list of mzQC MzQCqualityMetric's (named by their fc.raw.file for runQuality or concatenated fc.raw.files for setQualities (e.g. "file 1;file4")) (valid after setData() was called)}

\item{\code{qcCat}}{QC category (LC, MS, or prep)}

\item{\code{qcName}}{Name of the qcScore in the heatmap}

\item{\code{orderNr}}{Column index during heatmap generation and for the general order of plots}
}}


\examples{

require(ggplot2)
dd = data.frame(x=1:10, y=11:20)
a = qcMetric$new(helpText="small help text", 
                 ## arbitrary arguments, matched during setData()
                 workerFcn=function(.self, data, gtitle)
                 {
                   ## usually some code here to produce ggplots
                   pl = lapply(1:2, function(xx) {
                       ggplot(data) +
                         geom_point(aes(x=x*xx,y=y)) +
                         ggtitle(gtitle)
                     })
                     ## add mzQC metric for count of identified clusters
                     template_proteinCount = rmzqc::getQualityMetricTemplate("MS:1002406") 
                     mzqc = lapply(1:3, function(id){
                       out = template_proteinCount$copy();
                       out$value = id;
                       return(out) })
                     names(mzqc) = paste0("file", 1:3);
                   return(list(plots = pl, mzQC = mzqc))
                 }, 
                 qcCat="LC", 
                 qcName="MS/MS Peak shape", 
                 orderNr = 30)
## test some output
a$setData(dd, "my title")
a$plots  ## the raw plots
a$getPlots(TRUE) ## same as above
a$getPlots(FALSE) ## plots without title
a$getTitles()  ## get the titles of the all plots
a$helpText
a$qcName
a$mzQC


}
