
qcMetric_PAR =  setRefClass(
  "qcMetric_PAR",
  contains = "qcMetric",
  methods = list(initialize=function() {  callSuper(
    helpText="MaxQuant parameters, extracted from parameters.txt (abbreviated as 'PAR'), summarizes the settings used for the MaxQuant analysis. 
Key parameters are MaxQuant version, Re-quantify, Match-between-runs and mass search tolerances. 
A list of protein database files is also provided, allowing to 
track database completeness and database version information (if given in the filename).", 
    workerFcn=function(.self, d_parAll)
    {
      ##todo: read in mqpar.xml to get group information and ppm tolerances for all groups (parameters.txt just gives Group1)

      line_break = "\n"; ## use space to make it work with table
      ## remove AIF stuff
      
      df_mqpar = d_parAll[!grepl("^AIF ", d_parAll$parameter),]
      df_mqpar$value = gsub(";", line_break, df_mqpar$value)
      ## seperate FASTA files (usually they destroy the layout)
      idx_fastafile = grepl("fasta file", df_mqpar$parameter, ignore.case = TRUE)
      d_par_file = df_mqpar[idx_fastafile, ]
      fasta_files = sapply(unlist(strsplit(d_par_file$value, "\n")), function(x) rev(strsplit(x,"\\", fixed = TRUE)[[1]])[1])
      d_par = df_mqpar[!idx_fastafile, ]
      ## remove duplicates
      d_par = d_par[!duplicated(d_par$parameter),]
      rownames(d_par) = d_par$parameter
      
      ## trim long param names (the user should know what they mean)
      allowed_len = nchar("Min. score for unmodified .."); 
      d_par$parameter = sapply(d_par$parameter, function (s) {
        if (nchar(s) > allowed_len) {
          s = paste(substring(s, 1, allowed_len), "..", collapse = "", sep="")
        }
        return (s)
      })
      
      
      ## sort by name
      d_par = d_par[order(d_par$parameter), ]

      ## two column layout
      if (nrow(d_par) %% 2 != 0) d_par[nrow(d_par)+1,] = ""  ## make even number of rows
      mid = nrow(d_par) / 2
      d_par$page = 1
      d_par$page[1:mid] = 0
      
      parC = c("parameter", "value")
     
      d_par2 = cbind(d_par[d_par$page==0, parC], d_par[d_par$page==1, parC])
      
      ## HTML: alternative table
      ## (do this before line breaks, since Html can handle larger strings)
      tbl_f = getHTMLTable(d_par2, caption = fasta_files)

      ## break long values into multiple lines (to preserve PDF table width)
      splitMaxLen = function(s) {
        allowed_len = nchar("Use least modified peptide"); ## this is a typical entry -- everything which is longer gets split
        r = paste(sapply(unlist(strsplit(s, line_break, fixed = TRUE)), function(s1) {
          if (!is.na(s1) && nchar(s1) > allowed_len) {
            s_beg = seq(from = 1, to = nchar(s1) - 1, by = allowed_len)
            s1 = paste(unlist(substring(s1, s_beg, s_beg + allowed_len - 1)), collapse = line_break)
          }
          return(s1)
        }), collapse = line_break)
        return (r)
      }
      d_par2[ , 2] = sapply(d_par2[ , 2], splitMaxLen)
      d_par2[ , 4] = sapply(d_par2[ , 4], splitMaxLen)
      
      plot_title = "PAR: parameters"
      ## PDF: split table onto multiple pages if necessary...
      par_pl = byXflex(d_par2, 1:nrow(d_par2), 25, plotTable, sort_indices = TRUE, title = plot_title, footer = fasta_files)
      
      return(list(plots = par_pl, htmlTable = tbl_f))
    }, 
    qcCat = NA_character_, 
    qcName = "PAR:~MQ~Parameters", 
    orderNr = 0001
  )
    return(.self)
  })
)

