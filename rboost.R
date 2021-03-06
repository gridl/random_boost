##
##															RBOOST
##

library(dplyr)
library(rpart)

# A convenient wrapper that checks user input an calls rboost_train, the
# actual function that carries out the random boosting
#
# arguments:
#		:arg formula: a formula
#		:arg data:    the dataframe on which to train the model
#		:arg params:  a list of obligatory parameters
# 			- eta:       learning rate
#				- max_depth: the maximum depth a tree can have
#				- n_rounds:  number of boosting iterations

rboost <- function(formula, data, params, randomize = TRUE) {
  
	comp_args <- c("formula", "data", "params")
	call <- match.call()
	idx <- match(comp_args, names(call), nomatch = 0L) # args missing?

	if (any(idx == 0))
		stop("Arguments are missing: ", paste(comp_args[idx == 0], collapse = ", "))

	comp_params <- c("eta", "max_depth", "n_rounds")
	missing <- base::setdiff(comp_params, names(params))
	if (length(missing) > 0) stop("Parameters are missing: ", missing)

	params <- params[comp_params] # only keep parameters that we need

	# Start training
	bst <- rboost_train(formula, data, params, randomize)

	structure(bst, class = "rboost")
}

