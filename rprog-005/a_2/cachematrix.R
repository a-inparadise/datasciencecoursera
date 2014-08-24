## Assignment: Caching the Inverse of a Matrix
# Matrix inversion is usually a costly computation and there may be some benefit to caching the inverse
# of a matrix rather than computing it repeatedly (there are also alternatives to matrix inversion that 
# we will not discuss here). Your assignment is to write a pair of functions that cache the inverse of a matrix.

## makeCacheMatrix --
# This function creates a special "matrix" object that can cache its inverse
makeCacheMatrix <- function(x = matrix()) {
  # initially set the cached inverse to NULL
  i <- NULL
  
  set <- function(y) {
    # on set cache the incoming value
    x <<- y
    
    # null out the cached inverse when set
    i <<- NULL
  }
  
  # getters and setters
  get <- function() x
  setinverse <- function(inverse) i <<- inverse
  getinverse <- function() i
  
  # create the special object
  list(set = set, get = get,
       setinverse = setinverse,
       getinverse = getinverse)
}


## cacheSolve --
# This function computes the inverse of the special "matrix" returned by makeCacheMatrix above. 
# If the inverse has already been calculated (and the matrix has not changed), then the cachesolve 
# should retrieve the inverse from the cache.
cacheSolve <- function(x, ...) {
  # grab the cached inverse
  i <- x$getinverse()
  if(!is.null(i)) {
    message("Getting cached inverse...")
    
    # return the cached inverse
    return(i)
  }
  
  # get the data from the special object
  data <- x$get()
  
  # solve the inverse for the data
  i <- solve(data, ...)
  
  # set the inverse value for caching
  x$setinverse(i)
  
  # return the new inverse
  i
}
