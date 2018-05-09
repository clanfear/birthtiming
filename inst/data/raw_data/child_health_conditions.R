
# Set working directory
# setwd()


new_data <- read.table('./inst/data/raw_data/child_health_conditions.dat', sep=' ')
names(new_data) <- c('C0000100',
  'C0000200',
  'C0005300',
  'C0005400',
  'C0005700',
  'C0404600',
  'C0404700',
  'C0404800',
  'C0593300',
  'C0593400',
  'C0593500',
  'C0812300',
  'C0812400',
  'C0812500',
  'C1002300',
  'C1002400',
  'C1002500',
  'C1206000',
  'C1206100',
  'C1206200',
  'C1526000',
  'C1526100',
  'C1526200',
  'C1772300',
  'C1772400',
  'C1772500',
  'C2254100',
  'C2254200',
  'C2254300',
  'Y2267000')


# Handle missing values

  new_data[new_data == -1] = NA  # Refused
  new_data[new_data == -2] = NA  # Dont know
  new_data[new_data == -3] = NA  # Invalid missing
  new_data[new_data == -7] = NA  # Missing


# If there are values not categorized they will be represented as NA

vallabels = function(data) {
  data$C0000100[1.0 <= data$C0000100 & data$C0000100 <= 9999999.0] <- 1.0
  data$C0000100 <- factor(data$C0000100,
    levels=c(1.0),
    labels=c("1 TO 9999999: See Min & Max values below for range as of this release"))
  data$C0000200[1.0 <= data$C0000200 & data$C0000200 <= 12686.0] <- 1.0
  data$C0000200 <- factor(data$C0000200,
    levels=c(1.0),
    labels=c("1 TO 12686: NLSY79 Public ID"))
  data$C0005300 <- factor(data$C0005300,
    levels=c(1.0,2.0,3.0),
    labels=c("HISPANIC",
      "BLACK",
      "NON-BLACK, NON-HISPANIC"))
  data$C0005400 <- factor(data$C0005400,
    levels=c(1.0,2.0),
    labels=c("MALE",
      "FEMALE"))
  data$C0005700[1970.0 <= data$C0005700 & data$C0005700 <= 1978.0] <- 1970.0
  data$C0005700 <- factor(data$C0005700,
    levels=c(1970.0,1979.0,1980.0,1981.0,1982.0,1983.0,1984.0,1985.0,1986.0,1987.0,1988.0,1989.0,1990.0,1991.0,1992.0,1993.0,1994.0,1995.0,1996.0,1997.0,1998.0,1999.0,2000.0,2001.0,2002.0,2003.0,2004.0,2005.0,2006.0,2007.0,2008.0,2009.0,2010.0,2011.0,2012.0,2013.0,2014.0,2015.0),
    labels=c("1970 TO 1978: < before 1979",
      "1979",
      "1980",
      "1981",
      "1982",
      "1983",
      "1984",
      "1985",
      "1986",
      "1987",
      "1988",
      "1989",
      "1990",
      "1991",
      "1992",
      "1993",
      "1994",
      "1995",
      "1996",
      "1997",
      "1998",
      "1999",
      "2000",
      "2001",
      "2002",
      "2003",
      "2004",
      "2005",
      "2006",
      "2007",
      "2008",
      "2009",
      "2010",
      "2011",
      "2012",
      "2013",
      "2014",
      "2015"))
  data$C0404600 <- factor(data$C0404600,
    levels=c(0.0,1.0),
    labels=c("NO",
      "YES"))
  data$C0404700 <- factor(data$C0404700,
    levels=c(0.0,1.0),
    labels=c("NO",
      "YES"))
  data$C0404800 <- factor(data$C0404800,
    levels=c(0.0,1.0),
    labels=c("NO",
      "YES"))
  data$C0593300 <- factor(data$C0593300,
    levels=c(0.0,1.0),
    labels=c("NO",
      "YES"))
  data$C0593400 <- factor(data$C0593400,
    levels=c(0.0,1.0),
    labels=c("NO",
      "YES"))
  data$C0593500 <- factor(data$C0593500,
    levels=c(0.0,1.0),
    labels=c("NO",
      "YES"))
  data$C0812300 <- factor(data$C0812300,
    levels=c(0.0,1.0),
    labels=c("NO",
      "YES"))
  data$C0812400 <- factor(data$C0812400,
    levels=c(0.0,1.0),
    labels=c("NO",
      "YES"))
  data$C0812500 <- factor(data$C0812500,
    levels=c(0.0,1.0),
    labels=c("NO",
      "YES"))
  data$C1002300 <- factor(data$C1002300,
    levels=c(0.0,1.0),
    labels=c("NO",
      "YES"))
  data$C1002400 <- factor(data$C1002400,
    levels=c(0.0,1.0),
    labels=c("NO",
      "YES"))
  data$C1002500 <- factor(data$C1002500,
    levels=c(0.0,1.0),
    labels=c("NO",
      "YES"))
  data$C1206000 <- factor(data$C1206000,
    levels=c(0.0,1.0),
    labels=c("NO",
      "YES"))
  data$C1206100 <- factor(data$C1206100,
    levels=c(0.0,1.0),
    labels=c("NO",
      "YES"))
  data$C1206200 <- factor(data$C1206200,
    levels=c(0.0,1.0),
    labels=c("NO",
      "YES"))
  data$C1526000 <- factor(data$C1526000,
    levels=c(0.0,1.0),
    labels=c("No",
      "Yes"))
  data$C1526100 <- factor(data$C1526100,
    levels=c(0.0,1.0),
    labels=c("No",
      "Yes"))
  data$C1526200 <- factor(data$C1526200,
    levels=c(0.0,1.0),
    labels=c("No",
      "Yes"))
  data$C1772300 <- factor(data$C1772300,
    levels=c(0.0,1.0),
    labels=c("No",
      "Yes"))
  data$C1772400 <- factor(data$C1772400,
    levels=c(0.0,1.0),
    labels=c("No",
      "Yes"))
  data$C1772500 <- factor(data$C1772500,
    levels=c(0.0,1.0),
    labels=c("No",
      "Yes"))
  data$C2254100 <- factor(data$C2254100,
    levels=c(0.0,1.0),
    labels=c("No",
      "Yes"))
  data$C2254200 <- factor(data$C2254200,
    levels=c(0.0,1.0),
    labels=c("No",
      "Yes"))
  data$C2254300 <- factor(data$C2254300,
    levels=c(0.0,1.0),
    labels=c("No",
      "Yes"))
  data$Y2267000 <- factor(data$Y2267000,
    levels=c(458.0),
    labels=c("458"))
  return(data)
}

varlabels <- c("ID CODE OF CHILD",
  "ID CODE OF MOTHER OF CHILD",
  "RACE OF CHILD (FROM MOTHERS SCREENER 79)",
  "SEX OF CHILD",
  "DATE OF BIRTH OF CHILD - YEAR",
  "HLTH SEC 2 CONDITION REQUIRE A DOCTOR",
  "HLTH SEC 2 CONDITION REQUIRE USE MEDIC",
  "HLTH SEC 2 REQUIRES SPECIAL EQPMNT",
  "CHLD HAS COND THAT REQUIRES TREATMENT",
  "CHLD HAS COND THAT REQUIRES MEDICINE",
  "CHLD HS COND THAT REQ SPECIAL EQUIPMNT",
  "CONDITION REQUIRES ATTENTION FROM DOCTOR",
  "CONDITION REQUIRES USE OF MEDICINE,DRUGS",
  "CONDITION REQUIRES USE OF SPECIAL EQUIP.",
  "CH HAS CONDIT THAT REQIRES ATTN FR DR-92",
  "CH HAS CONDIT THAT REQS MEDICN/DRUGS-92",
  "CH HAS CONDIT REQS USE OF SPEC EQUIP-92",
  "CH HAS CONDIT THAT REQIRES ATTN FR DR 94",
  "CH HAS CONDIT THAT REQS MEDICN/DRUGS 94",
  "CH HAS CONDIT REQS USE OF SPEC EQUIP 94",
  "CH HAS CONDIT THAT REQIRES ATTN FR DR 96",
  "CH HAS CONDIT THAT REQS MEDICN/DRUGS 96",
  "CH HAS CONDIT REQS USE OF SPEC EQUIP 96",
  "CH HAS CONDIT THAT REQS MED  ATTN 1998",
  "CH HAS CONDIT THAT REQS MEDICATION 1998",
  "CH HAS CONDIT REQS USE OF EQUIPMNT 1998",
  "CH HAS CONDIT THAT REQS MED  ATTN 2000",
  "CH HAS CONDIT THAT REQS MEDICATION 2000",
  "CH HAS CONDIT REQS USE OF EQUIPMNT 2000",
  "VERSION_R26 CHILD/YOUNG ADULT XRND"
)


# Use qnames rather than rnums

bt_names = function(data) {
  names(data) <- c(
    "child_id",
    "mother_id",
    "race",
    "sex",
    "birth_year",
    "treatment_1986",
    "medicine__1986",
    "equipment_1986",
    "treatment_1988",
    "medicine__1988",
    "equipment_1988",
    "treatment_1990",
    "medicine__1990",
    "equipment_1990",
    "treatment_1992",
    "medicine__1992",
    "equipment_1992",
    "treatment_1994",
    "medicine__1994",
    "equipment_1994",
    "treatment_1996",
    "medicine__1996",
    "equipment_1996",
    "treatment_1998",
    "medicine__1998",
    "equipment_1998",
    "treatment_2000",
    "medicine__2000",
    "equipment_2000",
    "VERSION_R26_XRND")
  return(data)
}

qnames = function(data) {
  names(data) <- c("child_id",
                   "mother_id",
                   "race",
                   "sex",
                   "birth_year",
                   "CS860656_1986",
                   "CS860657_1986",
                   "CS860658_1986",
                   "CS881145_1988",
                   "CS881146_1988",
                   "CS881147_1988",
                   "CS901637_1990",
                   "CS901639_1990",
                   "CS901641_1990",
                   "CS921764_1992",
                   "CS921766_1992",
                   "CS921768_1992",
                   "CS94H-3A_1994",
                   "CS94H-3B_1994",
                   "CS94H-3C_1994",
                   "CS96H-3A_1996",
                   "CS96H-3B_1996",
                   "CS96H-3C_1996",
                   "CS98H-3A_1998",
                   "CS98H-3B_1998",
                   "CS98H-3C_1998",
                   "HLTH-3A_2000",
                   "HLTH-3B_2000",
                   "HLTH-3C_2000",
                   "VERSION_R26_XRND")
  return(data)
}

#********************************************************************************************************

# Remove the '#' before the following line to create a data file called "categories" with value labels.
# categories <- vallabels(new_data)

# Remove the '#' before the following lines to rename variables using Qnames instead of Reference Numbers
#new_data <- qnames(new_data)
categories <- bt_names(new_data)

# Produce summaries for the raw (uncategorized) data file
# summary(new_data)

# Remove the '#' before the following lines to produce summaries for the "categories" data file.
#categories <- vallabels(new_data)
#summary(categories)

#************************************************************************************************************
bt_child_health <- categories
save(bt_child_health, file="./inst/data/raw_data/bt_child_health.RData")
