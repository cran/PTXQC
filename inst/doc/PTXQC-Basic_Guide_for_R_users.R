## ----eval=FALSE---------------------------------------------------------------
#  vignette("PTXQC-InputData", package = "PTXQC")

## ----eval=FALSE---------------------------------------------------------------
#  require(PTXQC)
#  
#  ## the next require() is needed to prevent a spurious error in certain R versions (might be a bug in R or a package)
#  ## error message is:
#  ##    Error in Scales$new : could not find function "loadMethod"
#  require(methods)
#  
#  ## specify a path to a MaxQuant txt folder
#  ## Note: This folder needs to be complete (see 'vignette("PTXQC-InputData", package = "PTXQC")')
#  if (1) {
#    ## we will use an example dataset from PRIDE (dataset 2 of the PTXQC publication)
#    local_zip = tempfile(fileext=".zip")
#    tryCatch({
#      download.file("ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2015/11/PXD003133/txt_20min.zip", destfile = local_zip)
#    }, error = function(err) {
#      ## on Windows, one can get a 'cannot open URL' using the default method. So we try another
#      download.file("ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2015/11/PXD003133/txt_20min.zip", destfile = local_zip, method= "internal")
#  
#    })
#    unzip(local_zip, exdir = tempdir()) ## extracts content
#    txt_folder = file.path(tempdir(), "txt_20min")
#  } else {
#    ## if you have local MaxQuant output, just use it
#    txt_folder = "c:/Proteomics/MouseLiver/combined/txt"
#  }
#  
#  r = createReport(txt_folder)
#  
#  cat(paste0("\nReport generated as '", r$report_file, "'\n\n"))
#  

## ----eval=FALSE---------------------------------------------------------------
#  vignette("PTXQC-CustomizeReport", package = "PTXQC")

## ----eval=FALSE---------------------------------------------------------------
#  require(PTXQC)
#  require(yaml)
#  
#  ## the next require() is needed to prevent a spurious error in certain R versions (might be a bug in R or a package)
#  ## error message is:
#  ##    Error in Scales$new : could not find function "loadMethod"
#  require(methods)
#  
#  ## specify a path to a MaxQuant txt folder
#  ## Note: This folder can be incomplete, depending on your YAML config
#  if (1) {
#    ## we will use an example dataset from PRIDE (dataset 2 of the PTXQC publication)
#    local_zip = tempfile(fileext=".zip")
#    download.file("ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2015/11/PXD003133/txt_20min.zip", destfile = local_zip)
#    unzip(local_zip, exdir = tempdir()) ## extracts content
#    txt_folder = file.path(tempdir(), "txt_20min")
#  } else {
#    ## if you have local MaxQuant output, just use it
#    txt_folder = "c:/Proteomics/MouseLiver/combined/txt"
#  }
#  
#  ## use a YAML config inside the target directory if present
#  fh_out = getReportFilenames(txt_folder)
#  if (file.exists(fh_out$yaml_file))
#  {
#    cat("\nUsing YAML config already present in target directory ...\n")
#    yaml_config = yaml.load_file(input = fh_out$yaml_file)
#  } else {
#    cat("\nYAML config not found in folder '", txt_folder, "'. The first run of PTXQC will create one for you.", sep="")
#    yaml_config = list()
#  }
#  
#  r = createReport(txt_folder, mztab_file = NULL, yaml_obj = yaml_config)
#  
#  cat(paste0("\nReport generated as '", r$report_file, "'\n\n"))
#  

