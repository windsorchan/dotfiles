# The .First function is called after everything else in .Rprofile is executed
.First <- function() {
  # Print a welcome message
  message("Welcome back ", Sys.getenv("USER"),"!\n","working directory is:", getwd())
}

options(repos = c(ffverse = 'https://ffverse.r-universe.dev', CRAN = 'https://cloud.r-project.org'))
options(digits = 12)                                          # number of digits to print. Default is 7, max is 15
options(width = 220)
options(stringsAsFactors = FALSE)                             # Disable default conversion of character strings to factors
options(show.signif.stars = FALSE)                            # Don't show stars indicating statistical significance in model outputs
error <- quote(dump.frames("${R_HOME_USER}/testdump", TRUE))  # post-mortem debugging facilities
