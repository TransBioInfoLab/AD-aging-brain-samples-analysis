TestAllRegions_noInfo <- function(predictors_char,
                                  covariates_char = NULL,
                                  pheno_df,
                                  summarizedRegions_df,
                                  cores = 1){
  
  parallel <- FALSE
  if (cores > 1){
    if (cores > parallel::detectCores()) cores <- parallel::detectCores()
    doParallel::registerDoParallel(cores)
    parallel = TRUE
  }
  
  results_ls <- plyr::alply(summarizedRegions_df,1, .fun = function(sumOneRegion_df){
    TestSingleRegion(
      predictors_char = predictors_char,
      covariates_char = covariates_char,
      pheno_df = pheno_df,
      sumOneRegion_df = sumOneRegion_df
    )
  }, .progress = "time", .parallel = parallel)
  
  ### Output results
  if (length(results_ls) > 0){
    
    results_df <- do.call(rbind, results_ls)
    
    results_df$FDR <- p.adjust(
      results_df$pValue,
      method = "fdr"
    )
    
  }
  results_df  
}


TestSingleRegion <- function(predictors_char,
                             covariates_char = NULL,
                             pheno_df,
                             sumOneRegion_df){
  
  ### Transpose sumOneRegion_df from wide to long
  sumOneRegionTrans_df <- reshape(
    sumOneRegion_df,
    times = colnames(sumOneRegion_df),
    timevar = "Sample",
    varying = colnames(sumOneRegion_df),
    v.names = "MvalueSummary",
    direction = "long"
  )
  
  ### Merge pheno_df and rnaEditOne_num
  sumOnePheno_df <- merge(
    x = pheno_df,
    y = sumOneRegionTrans_df,
    by = "Sample"
  )
  
  ### Make model formula
  modelFormula_char <- .MakeModelFormula(
    predictors_char, covariates_char
  )
  
  ### Fit model
  f <- tryCatch({
    lm(as.formula(modelFormula_char), sumOnePheno_df)
  }, error = function(e){ 
    message(e);
    message(modelFormula_char);
    NULL 
  })
  
  if(is.null(f)){
    
    result_df <- data.frame(
      Estimate = NA_real_,
      StdErr = NA_real_,
      pValue = 1,
      stringsAsFactors = FALSE
    )
    
  } else {
    
    result <- coef(summary(f))[2, c(1, 2, 4), drop = FALSE]
    result_df <- data.frame(result, stringsAsFactors = FALSE)
    colnames(result_df) <- c("Estimate", "StdErr", "pValue")
    rownames(result_df) <- NULL
    
  }
  
  result_df
  
}


.MakeModelFormula <- function(predictors_char,
                              covariates_char = NULL){
  
  mainMod_char <- paste("MvalueSummary", predictors_char, sep = " ~ ")
  
  if (!is.null(covariates_char)){
    
    covMod_char <- paste(covariates_char, collapse = " + ")
    paste(mainMod_char, covMod_char, sep = " + ")
    
  } else {
    
    mainMod_char
    
  }
  
}


## This function draws the pca plot, and returns a dataset with outlier samples indicated

## dataset = character, name of the dataset
## expSorted_mat = expression matrix, rows sorted by most variable probes on top
## pheno = a data frame of phenotype values, must include variable "Sample"
## group_char = a character value for the groups to be indicated with different colors
## ntop = number of most variable features to draw pca plot
## center = whether to center when drawing the pca plot
## scale = whether to scale the pcas when drawing plot


plotPCA <- function (dataset, expSorted_mat, pheno, group_char, ntop, center, scale){
  
  # pca analysis
  pca <- prcomp ( t(expSorted_mat[1:ntop,]),
                  center = center,
                  scale = scale)
  
  # the contribution to the total variance for each component
  percentVar <- pca$sdev^2 / sum( pca$sdev^2 )
  
  # merge pheno info with PCs
  d <- data.frame(PC1=pca$x[,1], PC2=pca$x[,2])
  d <- d[as.character(pheno$sample) ,]
  
  test <- identical (as.character(pheno$sample), row.names (d))
  
  if (test == TRUE){
    
    plotData <- merge (d, pheno, by.x = "row.names", by.y = "sample")
    
    
    # add lines for 3 SD from mean
    meanPC1 <- mean (plotData$PC1)
    sdPC1   <- sd (plotData$PC1)
    
    meanPC2 <- mean (plotData$PC2)
    sdPC2   <- sd (plotData$PC2)
    
    # add flag for outlier samples
    plotData$outlier <- ifelse ( abs(plotData$PC1) > meanPC1 + 3*sdPC1 | abs(plotData$PC2) > meanPC2 + 3*sdPC2,
                                 1, 0 )
    
    plotData$outlier_name <- ifelse ( abs(plotData$PC1) > meanPC1 + 3*sdPC1 | abs(plotData$PC2) > meanPC2 + 3*sdPC2,
                                      plotData$Row.names, "" )
    
    title <- paste0("dataset = ", dataset, ", top = ", ntop, " probes ")
    subtitle <- paste0(" x: mean +/- 3*sdPC1 = ", round(meanPC1,1), " +/- 3*", round(sdPC1,1) ,
                       "     y: mean +/- 3*sdPC2 = ", round(meanPC2,1), " +/- 3*", round(sdPC2,1))
    
    p <- ggplot(data= plotData, aes_string(x="PC1", y="PC2", color = group_char)) +
      geom_point(size=1) +
      theme_bw() +
      xlab(paste0("PC1: ",round(percentVar[1] * 100),"% variance")) +
      ylab(paste0("PC2: ",round(percentVar[2] * 100),"% variance")) +
      ggtitle(title, subtitle = subtitle) +
      geom_hline (yintercept = meanPC2 + 3*sdPC2, linetype = "dashed") +
      geom_hline (yintercept = meanPC2 - 3*sdPC2, linetype = "dashed") +
      
      geom_vline (xintercept = meanPC1 + 3*sdPC1, linetype = "dashed") +
      geom_vline (xintercept = meanPC1 - 3*sdPC1, linetype = "dashed") +
      geom_text_repel (aes(label = outlier_name), show.legend = FALSE)
    
    print (p)
    
    
    return (plotData)
    
  }
}


## this function orders dataset by most variable features first
## exp_mat = expression matrix, with row names = feature ids, columns = sample ids

## returns:
## - a matrix with features sorted by most variable features on top

OrderDataBySd <- function(exp_mat){
  # compute sds for each row
  sds <- matrixStats::rowSds(exp_mat)
  sdsSorted <- order(sds, decreasing = TRUE)
  
  # order by most variable probes on top
  exp_mat[sdsSorted ,]
}



plotPCA2 <- function (
    object, 
    intgroup = "condition", 
    group.shape = NULL,
    ntop = 500, 
    returnData = FALSE
) {
  rv <- rowVars(assay(object))
  select <- order(rv, decreasing = TRUE)[seq_len(min(ntop, length(rv)))]
  pca <- prcomp(t(assay(object)[select, ]))
  percentVar <- pca$sdev^2/sum(pca$sdev^2)
  if (!all(intgroup %in% names(colData(object)))) {
    stop("the argument 'intgroup' should specify columns of colData(dds)")
  }
  intgroup.df <- as.data.frame(colData(object)[, intgroup, drop = FALSE])
  group <- factor(apply(intgroup.df, 1, paste, collapse = ":"))
  
  group.shape.df <- as.data.frame(colData(object)[, group.shape, drop = FALSE])
  group.shape <-  factor(apply(group.shape.df, 1, paste, collapse = ":"))
  
  print(group.shape)
  
  d <- data.frame(
    PC1 = pca$x[, 1], 
    PC2 = pca$x[, 2], 
    group = group, 
    intgroup.df, 
    group.shape = group.shape,
    name = colnames(object)
  )
  if (returnData) {
    attr(d, "percentVar") <- percentVar[1:2]
    return(d)
  }
  print(d)
  ggplot(data = d, aes_string(x = "PC1", y = "PC2", color = "group", shape = "group.shape")) + 
    geom_point(size = 3) + 
    xlab(paste0("PC1: ", round(percentVar[1] * 100), "% variance")) + 
    ylab(paste0("PC2: ", round(percentVar[2] * 100), "% variance")) + 
    coord_fixed()
}