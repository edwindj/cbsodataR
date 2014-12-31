transitive_closure <- function(node){
  # assume parent and child share levels
  
}

update_levels <- function(node, parent="parent", child="child"){
  #TODO check
  pa <- as.character(node[[parent]])
  ch <- as.character(node[[child]])
  
  levs <- sort(unique(c(pa, ch)))
  # let them use the same levels...
  node[[parent]] <- factor(node[[parent]], levels = levs)
  node[[child]] <- factor(node[[child]], levels = levs)
  node
}

make_adjmatrix <- function(node, parent="parent", child="child"){
  pa <- as.factor(node[[parent]])
  ch <- as.factor(node[[child]])
  A <- matrix( FALSE, nrow = nlevels(pa), ncol=nlevels(ch),
               dimnames=list( parent=levels(pa), child=levels(ch))
             )
  A[cbind(pa, ch)] <- TRUE
  A
}

make_closure <- function(A){
  A_ <- NA
  while(!identical(A, A_)){
    A_ <- A
    for (r in 1:nrow(A)){
      child_idx <- which(A[r,])
      A[, child_idx] <- A[,child_idx] | A[,r]
    }
  }
  A
}

### testing 1,2,3

# library(magrittr)
# 
# node <- read.csv(textConnection(
# "parent,child
# 1,2
# 1,3
# 3,4
# 4,5
# 5,6"
# ))
# 
# node %>%
#   update_levels %>% 
#   make_adjmatrix %>%
#   make_closure %>%
#   print
