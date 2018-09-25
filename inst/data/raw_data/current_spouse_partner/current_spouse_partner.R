
# Set working directory
# setwd()


new_data <- read.table('current_spouse_partner.dat', sep=' ')
names(new_data) <- c('R0000100',
  'R0218004',
  'R0407604',
  'R0647105',
  'R0898856',
  'R1146848',
  'R1522064',
  'R1892766',
  'R2259866',
  'R2448059',
  'R2881300',
  'R3076874',
  'R3411240',
  'R3659081',
  'R4009488',
  'R4447100',
  'R5090402',
  'R5176202',
  'R6489402',
  'R7017202',
  'R7714702',
  'R8523002',
  'R9910800',
  'R9911000',
  'R9911400',
  'R9911600',
  'T1026702')


# Handle missing values

  new_data[new_data == -1] = NA  # Refused 
  new_data[new_data == -2] = NA  # Dont know 
  new_data[new_data == -3] = NA  # Invalid missing 
  new_data[new_data == -4] = NA  # Valid missing 
  new_data[new_data == -5] = NA  # Non-interview 


# If there are values not categorized they will be represented as NA

vallabels = function(data) {
  data$R0218004 <- factor(data$R0218004, 
    levels=c(-999.0,0.0,1.0,33.0,36.0), 
    labels=c("-999: Never reported spouse/partner",
      "0: No current spouse/partner",
      "1: Spouse",
      "33: Partner",
      "36: Other"))
  data$R0407604 <- factor(data$R0407604, 
    levels=c(-999.0,0.0,1.0,33.0,36.0), 
    labels=c("-999: Never reported spouse/partner",
      "0: No current spouse/partner",
      "1: Spouse",
      "33: Partner",
      "36: Other"))
  data$R0647105 <- factor(data$R0647105, 
    levels=c(-999.0,0.0,1.0,33.0,36.0), 
    labels=c("-999: Never reported spouse/partner",
      "0: No current spouse/partner",
      "1: Spouse",
      "33: Partner",
      "36: Other"))
  data$R0898856 <- factor(data$R0898856, 
    levels=c(-999.0,0.0,1.0,33.0,36.0), 
    labels=c("-999: Never reported spouse/partner",
      "0: No current spouse/partner",
      "1: Spouse",
      "33: Partner",
      "36: Other"))
  data$R1146848 <- factor(data$R1146848, 
    levels=c(-999.0,0.0,1.0,33.0,36.0), 
    labels=c("-999: Never reported spouse/partner",
      "0: No current spouse/partner",
      "1: Spouse",
      "33: Partner",
      "36: Other"))
  data$R1522064 <- factor(data$R1522064, 
    levels=c(-999.0,0.0,1.0,33.0,36.0), 
    labels=c("-999: Never reported spouse/partner",
      "0: No current spouse/partner",
      "1: Spouse",
      "33: Partner",
      "36: Other"))
  data$R1892766 <- factor(data$R1892766, 
    levels=c(-999.0,0.0,1.0,33.0,36.0), 
    labels=c("-999: Never reported spouse/partner",
      "0: No current spouse/partner",
      "1: Spouse",
      "33: Partner",
      "36: Other"))
  data$R2259866 <- factor(data$R2259866, 
    levels=c(-999.0,0.0,1.0,33.0,36.0), 
    labels=c("-999: Never reported spouse/partner",
      "0: No current spouse/partner",
      "1: Spouse",
      "33: Partner",
      "36: Other"))
  data$R2448059 <- factor(data$R2448059, 
    levels=c(-999.0,0.0,1.0,33.0,36.0), 
    labels=c("-999: Never reported spouse/partner",
      "0: No current spouse/partner",
      "1: Spouse",
      "33: Partner",
      "36: Other"))
  data$R2881300 <- factor(data$R2881300, 
    levels=c(-999.0,0.0,1.0,33.0,36.0), 
    labels=c("-999: Never reported spouse/partner",
      "0: No current spouse/partner",
      "1: Spouse",
      "33: Partner",
      "36: Other"))
  data$R3076874 <- factor(data$R3076874, 
    levels=c(-999.0,0.0,1.0,33.0,36.0), 
    labels=c("-999: Never reported spouse/partner",
      "0: No current spouse/partner",
      "1: Spouse",
      "33: Partner",
      "36: Other"))
  data$R3411240 <- factor(data$R3411240, 
    levels=c(-999.0,0.0,1.0,33.0,36.0), 
    labels=c("-999: Never reported spouse/partner",
      "0: No current spouse/partner",
      "1: Spouse",
      "33: Partner",
      "36: Other"))
  data$R3659081 <- factor(data$R3659081, 
    levels=c(-999.0,0.0,1.0,33.0,36.0), 
    labels=c("-999: Never reported spouse/partner",
      "0: No current spouse/partner",
      "1: Spouse",
      "33: Partner",
      "36: Other"))
  data$R4009488 <- factor(data$R4009488, 
    levels=c(-999.0,0.0,1.0,33.0,36.0), 
    labels=c("-999: Never reported spouse/partner",
      "0: No current spouse/partner",
      "1: Spouse",
      "33: Partner",
      "36: Other"))
  data$R4447100 <- factor(data$R4447100, 
    levels=c(-999.0,0.0,1.0,33.0,36.0), 
    labels=c("-999: Never reported spouse/partner",
      "0: No current spouse/partner",
      "1: Spouse",
      "33: Partner",
      "36: Other"))
  data$R5090402 <- factor(data$R5090402, 
    levels=c(-999.0,0.0,1.0,33.0,36.0), 
    labels=c("-999: Never reported spouse/partner",
      "0: No current spouse/partner",
      "1: Spouse",
      "33: Partner",
      "36: Other"))
  data$R5176202 <- factor(data$R5176202, 
    levels=c(-999.0,0.0,1.0,33.0,36.0), 
    labels=c("-999: Never reported spouse/partner",
      "0: No current spouse/partner",
      "1: Spouse",
      "33: Partner",
      "36: Other"))
  data$R6489402 <- factor(data$R6489402, 
    levels=c(-999.0,0.0,1.0,33.0,36.0), 
    labels=c("-999: Never reported spouse/partner",
      "0: No current spouse/partner",
      "1: Spouse",
      "33: Partner",
      "36: Other"))
  data$R7017202 <- factor(data$R7017202, 
    levels=c(-999.0,0.0,1.0,33.0,36.0), 
    labels=c("-999: Never reported spouse/partner",
      "0: No current spouse/partner",
      "1: Spouse",
      "33: Partner",
      "36: Other"))
  data$R7714702 <- factor(data$R7714702, 
    levels=c(-999.0,0.0,1.0,33.0,36.0), 
    labels=c("-999: Never reported spouse/partner",
      "0: No current spouse/partner",
      "1: Spouse",
      "33: Partner",
      "36: Other"))
  data$R8523002 <- factor(data$R8523002, 
    levels=c(-999.0,0.0,1.0,33.0,36.0), 
    labels=c("-999: Never reported spouse/partner",
      "0: No current spouse/partner",
      "1: Spouse",
      "33: Partner",
      "36: Other"))
  data$R9910800 <- factor(data$R9910800, 
    levels=c(-999.0,0.0,1.0,33.0,36.0), 
    labels=c("-999: Never reported spouse/partner",
      "0: No current spouse/partner",
      "1: Spouse",
      "33: Partner",
      "36: Other"))
  data$R9911000 <- factor(data$R9911000, 
    levels=c(-999.0,0.0,1.0,33.0,36.0), 
    labels=c("-999: Never reported spouse/partner",
      "0: No current spouse/partner",
      "1: Spouse",
      "33: Partner",
      "36: Other"))
  data$R9911400 <- factor(data$R9911400, 
    levels=c(-999.0,0.0,1.0,33.0,36.0), 
    labels=c("-999: Never reported spouse/partner",
      "0: No current spouse/partner",
      "1: Spouse",
      "33: Partner",
      "36: Other"))
  data$R9911600 <- factor(data$R9911600, 
    levels=c(-999.0,0.0,1.0,33.0,36.0), 
    labels=c("-999: Never reported spouse/partner",
      "0: No current spouse/partner",
      "1: Spouse",
      "33: Partner",
      "36: Other"))
  data$T1026702 <- factor(data$T1026702, 
    levels=c(-999.0,0.0,1.0,33.0,36.0), 
    labels=c("-999: Never reported spouse/partner",
      "0: No current spouse/partner",
      "1: Spouse",
      "33: Partner",
      "36: Other"))
  return(data)
}

varlabels <- c("ID# (1-12686) 79",
  "REL CODE OF CURR SP/PTR, 1979 XRND",
  "REL CODE OF CURR SP/PTR, 1980 XRND",
  "REL CODE OF CURR SP/PTR, 1981 XRND",
  "REL CODE OF CURR SP/PTR, 1982 XRND",
  "REL CODE OF CURR SP/PTR, 1983 XRND",
  "REL CODE OF CURR SP/PTR, 1984 XRND",
  "REL CODE OF CURR SP/PTR, 1985 XRND",
  "REL CODE OF CURR SP/PTR, 1986 XRND",
  "REL CODE OF CURR SP/PTR, 1987 XRND",
  "REL CODE OF CURR SP/PTR, 1988 XRND",
  "REL CODE OF CURR SP/PTR, 1989 XRND",
  "REL CODE OF CURR SP/PTR, 1990 XRND",
  "REL CODE OF CURR SP/PTR, 1991 XRND",
  "REL CODE OF CURR SP/PTR, 1992 XRND",
  "REL CODE OF CURR SP/PTR, 1993 XRND",
  "REL CODE OF CURR SP/PTR, 1994 XRND",
  "REL CODE OF CURR SP/PTR, 1996 XRND",
  "REL CODE OF CURR SP/PTR, 1998 XRND",
  "REL CODE OF CURR SP/PTR, 2000 XRND",
  "REL CODE OF CURR SP/PTR, 2002 XRND",
  "REL CODE OF CURR SP/PTR, 2004 XRND",
  "REL CODE OF CURR SP/PTR, 2008 XRND",
  "REL CODE OF CURR SP/PTR, 2010 XRND",
  "REL CODE OF CURR SP/PTR, 2012 XRND",
  "REL CODE OF CURR SP/PTR, 2014 XRND",
  "REL CODE OF CURR SP/PTR, 2006 XRND"
)


# Use qnames rather than rnums

qnames = function(data) {
  names(data) <- c("CASEID_1979",
    "RELSPPTR79_XRND",
    "RELSPPTR80_XRND",
    "RELSPPTR81_XRND",
    "RELSPPTR82_XRND",
    "RELSPPTR83_XRND",
    "RELSPPTR84_XRND",
    "RELSPPTR85_XRND",
    "RELSPPTR86_XRND",
    "RELSPPTR87_XRND",
    "RELSPPTR88_XRND",
    "RELSPPTR89_XRND",
    "RELSPPTR90_XRND",
    "RELSPPTR91_XRND",
    "RELSPPTR92_XRND",
    "RELSPPTR93_XRND",
    "RELSPPTR94_XRND",
    "RELSPPTR96_XRND",
    "RELSPPTR98_XRND",
    "RELSPPTR00_XRND",
    "RELSPPTR02_XRND",
    "RELSPPTR04_XRND",
    "RELSPPTR08_XRND",
    "RELSPPTR10_XRND",
    "RELSPPTR12_XRND",
    "RELSPPTR14_XRND",
    "RELSPPTR06_XRND")
  return(data)
}


#********************************************************************************************************

# Remove the '#' before the following line to create a data file called "categories" with value labels. 
#categories <- vallabels(new_data)

# Remove the '#' before the following lines to rename variables using Qnames instead of Reference Numbers
#new_data <- qnames(new_data)
#categories <- qnames(categories)

# Produce summaries for the raw (uncategorized) data file
summary(new_data)

# Remove the '#' before the following lines to produce summaries for the "categories" data file.
#categories <- vallabels(new_data)
#summary(categories)

#************************************************************************************************************

