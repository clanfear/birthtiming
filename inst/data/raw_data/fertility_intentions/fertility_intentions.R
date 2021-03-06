
# Set working directory
# setwd()


new_data <- read.table('fertility_intentions.dat', sep=' ')
names(new_data) <- c('R0000100',
  'R0769500',
  'R0769600',
  'R0770100',
  'R0770200',
  'R0770700',
  'R0770800',
  'R0771300',
  'R0771400',
  'R0771900',
  'R0772000',
  'R0772500',
  'R0772600',
  'R0773100',
  'R0773200',
  'R1017500',
  'R1017600',
  'R1018100',
  'R1018200',
  'R1018700',
  'R1018800',
  'R1019200',
  'R1019300',
  'R1019700',
  'R1019800',
  'R1325400',
  'R1325500',
  'R1326000',
  'R1326100',
  'R1326700',
  'R1327200',
  'R1327300',
  'R1702800',
  'R1702900',
  'R1703400',
  'R1703500',
  'R1704000',
  'R1704100',
  'R2002900',
  'R2003000',
  'R2003500',
  'R2003600',
  'R2579200',
  'R2579300',
  'R2581300',
  'R2581400',
  'R2583400',
  'R2583500',
  'R3188900',
  'R3189000',
  'R3190400',
  'R3190500',
  'R3191900',
  'R3192000',
  'R3792500',
  'R3792600',
  'R3806400',
  'R3806500',
  'R4855400',
  'R4855500',
  'R4873100',
  'R4873200',
  'R5525500',
  'R5525600',
  'R5536500',
  'R5536600',
  'R6249600',
  'R6249700',
  'R6250000',
  'R6250100',
  'R6801500',
  'R6801600',
  'R6801700',
  'R6801800',
  'R7449000',
  'R7449100',
  'R7449200',
  'R7449300',
  'R7449400',
  'R7449500',
  'R7449600',
  'R7449700',
  'R7449800',
  'R7449900',
  'R7450000',
  'R7450100',
  'R7450200',
  'R7450300',
  'R7450400',
  'R7450500',
  'R7450600',
  'R8159300',
  'R8159400',
  'R8159500',
  'R8159600',
  'R8159700',
  'R8159800',
  'R8159900',
  'R8160000',
  'R8160100',
  'R8160200',
  'R8160300',
  'R8160400',
  'T0369300',
  'T0369400',
  'T0369500',
  'T0369600',
  'T0369700',
  'T0369800',
  'T0369900',
  'T0370000',
  'T0370100',
  'T0370200',
  'T1521700',
  'T1521800',
  'T1521900',
  'T1522000',
  'T1522100',
  'T1522200',
  'T1522300',
  'T1522400',
  'T1522500',
  'T1522600',
  'T1522700',
  'T1522800',
  'T1522900',
  'T2562900',
  'T2563000',
  'T2563100',
  'T2563200',
  'T2563300',
  'T2563400',
  'T2563500',
  'T3547400',
  'T3547500',
  'T4521300',
  'T4521400',
  'T4521500',
  'T4521600',
  'T4521700')


# Handle missing values

  new_data[new_data == -1] = NA  # Refused 
  new_data[new_data == -2] = NA  # Dont know 
  new_data[new_data == -3] = NA  # Invalid missing 
  new_data[new_data == -4] = NA  # Valid missing 
  new_data[new_data == -5] = NA  # Non-interview 


# If there are values not categorized they will be represented as NA

vallabels = function(data) {
  data$R0769500 <- factor(data$R0769500, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("YES",
      "DIDN'T MATTER",
      "NO, NOT AT THAT TIME",
      "NO, NONE AT ALL"))
  data$R0769600 <- factor(data$R0769600, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("YES",
      "DIDN'T MATTER",
      "NO, NOT AT THAT TIME",
      "NO, NONE AT ALL"))
  data$R0770100 <- factor(data$R0770100, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("YES",
      "DIDN'T MATTER",
      "NO, NOT AT THAT TIME",
      "NO, NONE AT ALL"))
  data$R0770200 <- factor(data$R0770200, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("YES",
      "DIDN'T MATTER",
      "NO, NOT AT THAT TIME",
      "NO, NONE AT ALL"))
  data$R0770700 <- factor(data$R0770700, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("YES",
      "DIDN'T MATTER",
      "NO, NOT AT THAT TIME",
      "NO, NONE AT ALL"))
  data$R0770800 <- factor(data$R0770800, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("YES",
      "DIDN'T MATTER",
      "NO, NOT AT THAT TIME",
      "NO, NONE AT ALL"))
  data$R0771300 <- factor(data$R0771300, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("YES",
      "DIDN'T MATTER",
      "NO, NOT AT THAT TIME",
      "NO, NONE AT ALL"))
  data$R0771400 <- factor(data$R0771400, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("YES",
      "DIDN'T MATTER",
      "NO, NOT AT THAT TIME",
      "NO, NONE AT ALL"))
  data$R0771900 <- factor(data$R0771900, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("YES",
      "DIDN'T MATTER",
      "NO, NOT AT THAT TIME",
      "NO, NONE AT ALL"))
  data$R0772000 <- factor(data$R0772000, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("YES",
      "DIDN'T MATTER",
      "NO, NOT AT THAT TIME",
      "NO, NONE AT ALL"))
  data$R0772500 <- factor(data$R0772500, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("YES",
      "DIDN'T MATTER",
      "NO, NOT AT THAT TIME",
      "NO, NONE AT ALL"))
  data$R0772600 <- factor(data$R0772600, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("YES",
      "DIDN'T MATTER",
      "NO, NOT AT THAT TIME",
      "NO, NONE AT ALL"))
  data$R0773100 <- factor(data$R0773100, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("YES",
      "DIDN'T MATTER",
      "NO, NOT AT THAT TIME",
      "NO, NONE AT ALL"))
  data$R0773200 <- factor(data$R0773200, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("YES",
      "DIDN'T MATTER",
      "NO, NOT AT THAT TIME",
      "NO, NONE AT ALL"))
  data$R1017500 <- factor(data$R1017500, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("YES",
      "DIDN'T MATTER",
      "NO, NOT AT THAT TIME",
      "NO, NONE AT ALL"))
  data$R1017600 <- factor(data$R1017600, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("YES",
      "DIDN'T MATTER",
      "NO, NOT AT THAT TIME",
      "NO, NONE AT ALL"))
  data$R1018100 <- factor(data$R1018100, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("YES",
      "DIDN'T MATTER",
      "NO, NOT AT THAT TIME",
      "NO, NONE AT ALL"))
  data$R1018200 <- factor(data$R1018200, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("YES",
      "DIDN'T MATTER",
      "NO, NOT AT THAT TIME",
      "NO, NONE AT ALL"))
  data$R1018700 <- factor(data$R1018700, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("YES",
      "DIDN'T MATTER",
      "NO, NOT AT THAT TIME",
      "NO, NONE AT ALL"))
  data$R1018800 <- factor(data$R1018800, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("YES",
      "DIDN'T MATTER",
      "NO, NOT AT THAT TIME",
      "NO, NONE AT ALL"))
  data$R1019200 <- factor(data$R1019200, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("YES",
      "DIDN'T MATTER",
      "NO, NOT AT THAT TIME",
      "NO, NONE AT ALL"))
  data$R1019300 <- factor(data$R1019300, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("YES",
      "DIDN'T MATTER",
      "NO, NOT AT THAT TIME",
      "NO, NONE AT ALL"))
  data$R1019700 <- factor(data$R1019700, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("YES",
      "DIDN'T MATTER",
      "NO, NOT AT THAT TIME",
      "NO, NONE AT ALL"))
  data$R1019800 <- factor(data$R1019800, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("YES",
      "DIDN'T MATTER",
      "NO, NOT AT THAT TIME",
      "NO, NONE AT ALL"))
  data$R1325400 <- factor(data$R1325400, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("YES",
      "DIDN'T MATTER",
      "NO, NOT AT THAT TIME",
      "NO, NONE AT ALL"))
  data$R1325500 <- factor(data$R1325500, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("YES",
      "DIDN'T MATTER",
      "NO, NOT AT THAT TIME",
      "NO, NONE AT ALL"))
  data$R1326000 <- factor(data$R1326000, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("YES",
      "DIDN'T MATTER",
      "NO, NOT AT THAT TIME",
      "NO, NONE AT ALL"))
  data$R1326100 <- factor(data$R1326100, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("YES",
      "DIDN'T MATTER",
      "NO, NOT AT THAT TIME",
      "NO, NONE AT ALL"))
  data$R1326700 <- factor(data$R1326700, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("YES",
      "DIDN'T MATTER",
      "NO, NOT AT THAT TIME",
      "NO, NONE AT ALL"))
  data$R1327200 <- factor(data$R1327200, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("YES",
      "DIDN'T MATTER",
      "NO, NOT AT THAT TIME",
      "NO, NONE AT ALL"))
  data$R1327300 <- factor(data$R1327300, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("YES",
      "DIDN'T MATTER",
      "NO, NOT AT THAT TIME",
      "NO, NONE AT ALL"))
  data$R1702800 <- factor(data$R1702800, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("YES",
      "DIDN'T MATTER",
      "NO, NOT AT THAT TIME",
      "NO, NONE AT ALL"))
  data$R1702900 <- factor(data$R1702900, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("YES",
      "DIDN'T MATTER",
      "NO, NOT AT THAT TIME",
      "NO, NONE AT ALL"))
  data$R1703400 <- factor(data$R1703400, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("YES",
      "DIDN'T MATTER",
      "NO, NOT AT THAT TIME",
      "NO, NONE AT ALL"))
  data$R1703500 <- factor(data$R1703500, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("YES",
      "DIDN'T MATTER",
      "NO, NOT AT THAT TIME",
      "NO, NONE AT ALL"))
  data$R1704000 <- factor(data$R1704000, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("YES",
      "DIDN'T MATTER",
      "NO, NOT AT THAT TIME",
      "NO, NONE AT ALL"))
  data$R1704100 <- factor(data$R1704100, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("YES",
      "DIDN'T MATTER",
      "NO, NOT AT THAT TIME",
      "NO, NONE AT ALL"))
  data$R2002900 <- factor(data$R2002900, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("YES",
      "DIDN'T MATTER",
      "NO, NOT AT THAT TIME",
      "NO, NONE AT ALL"))
  data$R2003000 <- factor(data$R2003000, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("YES",
      "DIDN'T MATTER",
      "NO, NOT AT THAT TIME",
      "NO, NONE AT ALL"))
  data$R2003500 <- factor(data$R2003500, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("YES",
      "DIDN'T MATTER",
      "NO, NOT AT THAT TIME",
      "NO, NONE AT ALL"))
  data$R2003600 <- factor(data$R2003600, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("YES",
      "DIDN'T MATTER",
      "NO, NOT AT THAT TIME",
      "NO, NONE AT ALL"))
  data$R2579200 <- factor(data$R2579200, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("YES",
      "DIDN'T MATTER",
      "NO, NOT AT THAT TIME",
      "NO, NONE AT ALL"))
  data$R2579300 <- factor(data$R2579300, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("YES",
      "DIDN'T MATTER",
      "NO, NOT AT THAT TIME",
      "NO, NONE AT ALL"))
  data$R2581300 <- factor(data$R2581300, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("YES",
      "DIDN'T MATTER",
      "NO, NOT AT THAT TIME",
      "NO, NONE AT ALL"))
  data$R2581400 <- factor(data$R2581400, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("YES",
      "DIDN'T MATTER",
      "NO, NOT AT THAT TIME",
      "NO, NONE AT ALL"))
  data$R2583400 <- factor(data$R2583400, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("YES",
      "DIDN'T MATTER",
      "NO, NOT AT THAT TIME",
      "NO, NONE AT ALL"))
  data$R2583500 <- factor(data$R2583500, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("YES",
      "DIDN'T MATTER",
      "NO, NOT AT THAT TIME",
      "NO, NONE AT ALL"))
  data$R3188900 <- factor(data$R3188900, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("YES",
      "DIDN'T MATTER",
      "NO, NOT AT THAT TIME",
      "NO, NONE AT ALL"))
  data$R3189000 <- factor(data$R3189000, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("YES",
      "DIDN'T MATTER",
      "NO, NOT AT THAT TIME",
      "NO, NONE AT ALL"))
  data$R3190400 <- factor(data$R3190400, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("YES",
      "DIDN'T MATTER",
      "NO, NOT AT THAT TIME",
      "NO, NONE AT ALL"))
  data$R3190500 <- factor(data$R3190500, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("YES",
      "DIDN'T MATTER",
      "NO, NOT AT THAT TIME",
      "NO, NONE AT ALL"))
  data$R3191900 <- factor(data$R3191900, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("YES",
      "DIDN'T MATTER",
      "NO, NOT AT THAT TIME",
      "NO, NONE AT ALL"))
  data$R3192000 <- factor(data$R3192000, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("YES",
      "DIDN'T MATTER",
      "NO, NOT AT THAT TIME",
      "NO, NONE AT ALL"))
  data$R3792500 <- factor(data$R3792500, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("YES",
      "DIDN'T MATTER",
      "NO, NOT AT THAT TIME",
      "NO, NONE AT ALL"))
  data$R3792600 <- factor(data$R3792600, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("YES",
      "DIDN'T MATTER",
      "NO, NOT AT THAT TIME",
      "NO, NONE AT ALL"))
  data$R3806400 <- factor(data$R3806400, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("YES",
      "DIDN'T MATTER",
      "NO, NOT AT THAT TIME",
      "NO, NONE AT ALL"))
  data$R3806500 <- factor(data$R3806500, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("YES",
      "DIDN'T MATTER",
      "NO, NOT AT THAT TIME",
      "NO, NONE AT ALL"))
  data$R4855400 <- factor(data$R4855400, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("Yes",
      "Didn't matter",
      "No--not at that time",
      "No--(none/no more) at all"))
  data$R4855500 <- factor(data$R4855500, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("Yes",
      "Didn't matter",
      "No--not at that time",
      "No--(none/no more) at all"))
  data$R4873100 <- factor(data$R4873100, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("Yes",
      "Didn't matter",
      "No--not at that time",
      "No--(none/no more) at all"))
  data$R4873200 <- factor(data$R4873200, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("Yes",
      "Didn't matter",
      "No--not at that time",
      "No--(none/no more) at all"))
  data$R5525500 <- factor(data$R5525500, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("Yes",
      "Didn't matter",
      "No--not at that time",
      "No--(none/no more) at all"))
  data$R5525600 <- factor(data$R5525600, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("Yes",
      "Didn't matter",
      "No--not at that time",
      "No--(none/no more) at all"))
  data$R5536500 <- factor(data$R5536500, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("Yes",
      "Didn't matter",
      "No--not at that time",
      "No--(none/no more) at all"))
  data$R5536600 <- factor(data$R5536600, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("Yes",
      "Didn't matter",
      "No--not at that time",
      "No--(none/no more) at all"))
  data$R6249600 <- factor(data$R6249600, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("Yes",
      "Didn't matter",
      "No--not at that time",
      "No--(none/no more) at all"))
  data$R6249700 <- factor(data$R6249700, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("Yes",
      "Didn't matter",
      "No--not at that time",
      "No--(none/no more) at all"))
  data$R6250000 <- factor(data$R6250000, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("Yes",
      "Didn't matter",
      "No--not at that time",
      "No--(none/no more) at all"))
  data$R6250100 <- factor(data$R6250100, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("Yes",
      "Didn't matter",
      "No--not at that time",
      "No--(none/no more) at all"))
  data$R6801500 <- factor(data$R6801500, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("Yes",
      "Didn't matter",
      "No--not at that time",
      "No--(none/no more) at all"))
  data$R6801600 <- factor(data$R6801600, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("Yes",
      "Didn't matter",
      "No--not at that time",
      "No--(none/no more) at all"))
  data$R6801700 <- factor(data$R6801700, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("Yes",
      "Didn't matter",
      "No--not at that time",
      "No--(none/no more) at all"))
  data$R6801800 <- factor(data$R6801800, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("Yes",
      "Didn't matter",
      "No--not at that time",
      "No--(none/no more) at all"))
  data$R7449000 <- factor(data$R7449000, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("Yes",
      "Didn't matter",
      "No--not at that time",
      "No--(none/no more) at all"))
  data$R7449100 <- factor(data$R7449100, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("Yes",
      "Didn't matter",
      "No--not at that time",
      "No--(none/no more) at all"))
  data$R7449200 <- factor(data$R7449200, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("Yes",
      "Didn't matter",
      "No--not at that time",
      "No--(none/no more) at all"))
  data$R7449300 <- factor(data$R7449300, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("Yes",
      "Didn't matter",
      "No--not at that time",
      "No--(none/no more) at all"))
  data$R7449400 <- factor(data$R7449400, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("Yes",
      "Didn't matter",
      "No--not at that time",
      "No--(none/no more) at all"))
  data$R7449500 <- factor(data$R7449500, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("Yes",
      "Didn't matter",
      "No--not at that time",
      "No--(none/no more) at all"))
  data$R7449600 <- factor(data$R7449600, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("Yes",
      "Didn't matter",
      "No--not at that time",
      "No--(none/no more) at all"))
  data$R7449700 <- factor(data$R7449700, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("Yes",
      "Didn't matter",
      "No--not at that time",
      "No--(none/no more) at all"))
  data$R7449800 <- factor(data$R7449800, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("Yes",
      "Didn't matter",
      "No--not at that time",
      "No--(none/no more) at all"))
  data$R7449900 <- factor(data$R7449900, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("Yes",
      "Didn't matter",
      "No--not at that time",
      "No--(none/no more) at all"))
  data$R7450000 <- factor(data$R7450000, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("Yes",
      "Didn't matter",
      "No--not at that time",
      "No--(none/no more) at all"))
  data$R7450100 <- factor(data$R7450100, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("Yes",
      "Didn't matter",
      "No--not at that time",
      "No--(none/no more) at all"))
  data$R7450200 <- factor(data$R7450200, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("Yes",
      "Didn't matter",
      "No--not at that time",
      "No--(none/no more) at all"))
  data$R7450300 <- factor(data$R7450300, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("Yes",
      "Didn't matter",
      "No--not at that time",
      "No--(none/no more) at all"))
  data$R7450400 <- factor(data$R7450400, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("Yes",
      "Didn't matter",
      "No--not at that time",
      "No--(none/no more) at all"))
  data$R7450500 <- factor(data$R7450500, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("Yes",
      "Didn't matter",
      "No--not at that time",
      "No--(none/no more) at all"))
  data$R7450600 <- factor(data$R7450600, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("Yes",
      "Didn't matter",
      "No--not at that time",
      "No--(none/no more) at all"))
  data$R8159300 <- factor(data$R8159300, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("Yes",
      "Didn't matter",
      "No--not at that time",
      "No--(none/no more) at all"))
  data$R8159400 <- factor(data$R8159400, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("Yes",
      "Didn't matter",
      "No--not at that time",
      "No--(none/no more) at all"))
  data$R8159500 <- factor(data$R8159500, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("Yes",
      "Didn't matter",
      "No--not at that time",
      "No--(none/no more) at all"))
  data$R8159600 <- factor(data$R8159600, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("Yes",
      "Didn't matter",
      "No--not at that time",
      "No--(none/no more) at all"))
  data$R8159700 <- factor(data$R8159700, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("Yes",
      "Didn't matter",
      "No--not at that time",
      "No--(none/no more) at all"))
  data$R8159800 <- factor(data$R8159800, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("Yes",
      "Didn't matter",
      "No--not at that time",
      "No--(none/no more) at all"))
  data$R8159900 <- factor(data$R8159900, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("Yes",
      "Didn't matter",
      "No--not at that time",
      "No--(none/no more) at all"))
  data$R8160000 <- factor(data$R8160000, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("Yes",
      "Didn't matter",
      "No--not at that time",
      "No--(none/no more) at all"))
  data$R8160100 <- factor(data$R8160100, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("Yes",
      "Didn't matter",
      "No--not at that time",
      "No--(none/no more) at all"))
  data$R8160200 <- factor(data$R8160200, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("Yes",
      "Didn't matter",
      "No--not at that time",
      "No--(none/no more) at all"))
  data$R8160300 <- factor(data$R8160300, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("Yes",
      "Didn't matter",
      "No--not at that time",
      "No--(none/no more) at all"))
  data$R8160400 <- factor(data$R8160400, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("Yes",
      "Didn't matter",
      "No--not at that time",
      "No--(none/no more) at all"))
  data$T0369300 <- factor(data$T0369300, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("Yes",
      "Didn't matter",
      "No--not at that time",
      "No--(none/no more) at all"))
  data$T0369400 <- factor(data$T0369400, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("Yes",
      "Didn't matter",
      "No--not at that time",
      "No--(none/no more) at all"))
  data$T0369500 <- factor(data$T0369500, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("Yes",
      "Didn't matter",
      "No--not at that time",
      "No--(none/no more) at all"))
  data$T0369600 <- factor(data$T0369600, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("Yes",
      "Didn't matter",
      "No--not at that time",
      "No--(none/no more) at all"))
  data$T0369700 <- factor(data$T0369700, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("Yes",
      "Didn't matter",
      "No--not at that time",
      "No--(none/no more) at all"))
  data$T0369800 <- factor(data$T0369800, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("Yes",
      "Didn't matter",
      "No--not at that time",
      "No--(none/no more) at all"))
  data$T0369900 <- factor(data$T0369900, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("Yes",
      "Didn't matter",
      "No--not at that time",
      "No--(none/no more) at all"))
  data$T0370000 <- factor(data$T0370000, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("Yes",
      "Didn't matter",
      "No--not at that time",
      "No--(none/no more) at all"))
  data$T0370100 <- factor(data$T0370100, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("Yes",
      "Didn't matter",
      "No--not at that time",
      "No--(none/no more) at all"))
  data$T0370200 <- factor(data$T0370200, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("Yes",
      "Didn't matter",
      "No--not at that time",
      "No--(none/no more) at all"))
  data$T1521700 <- factor(data$T1521700, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("Yes",
      "Didn't matter",
      "No--not at that time",
      "No--(none/no more) at all"))
  data$T1521800 <- factor(data$T1521800, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("Yes",
      "Didn't matter",
      "No--not at that time",
      "No--(none/no more) at all"))
  data$T1521900 <- factor(data$T1521900, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("Yes",
      "Didn't matter",
      "No--not at that time",
      "No--(none/no more) at all"))
  data$T1522000 <- factor(data$T1522000, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("Yes",
      "Didn't matter",
      "No--not at that time",
      "No--(none/no more) at all"))
  data$T1522100 <- factor(data$T1522100, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("Yes",
      "Didn't matter",
      "No--not at that time",
      "No--(none/no more) at all"))
  data$T1522200 <- factor(data$T1522200, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("Yes",
      "Didn't matter",
      "No--not at that time",
      "No--(none/no more) at all"))
  data$T1522300 <- factor(data$T1522300, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("Yes",
      "Didn't matter",
      "No--not at that time",
      "No--(none/no more) at all"))
  data$T1522400 <- factor(data$T1522400, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("Yes",
      "Didn't matter",
      "No--not at that time",
      "No--(none/no more) at all"))
  data$T1522500 <- factor(data$T1522500, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("Yes",
      "Didn't matter",
      "No--not at that time",
      "No--(none/no more) at all"))
  data$T1522600 <- factor(data$T1522600, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("Yes",
      "Didn't matter",
      "No--not at that time",
      "No--(none/no more) at all"))
  data$T1522700 <- factor(data$T1522700, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("Yes",
      "Didn't matter",
      "No--not at that time",
      "No--(none/no more) at all"))
  data$T1522800 <- factor(data$T1522800, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("Yes",
      "Didn't matter",
      "No--not at that time",
      "No--(none/no more) at all"))
  data$T1522900 <- factor(data$T1522900, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("Yes",
      "Didn't matter",
      "No--not at that time",
      "No--(none/no more) at all"))
  data$T2562900 <- factor(data$T2562900, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("Yes",
      "Didn't matter",
      "No--not at that time",
      "No--(none/no more) at all"))
  data$T2563000 <- factor(data$T2563000, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("Yes",
      "Didn't matter",
      "No--not at that time",
      "No--(none/no more) at all"))
  data$T2563100 <- factor(data$T2563100, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("Yes",
      "Didn't matter",
      "No--not at that time",
      "No--(none/no more) at all"))
  data$T2563200 <- factor(data$T2563200, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("Yes",
      "Didn't matter",
      "No--not at that time",
      "No--(none/no more) at all"))
  data$T2563300 <- factor(data$T2563300, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("Yes",
      "Didn't matter",
      "No--not at that time",
      "No--(none/no more) at all"))
  data$T2563400 <- factor(data$T2563400, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("Yes",
      "Didn't matter",
      "No--not at that time",
      "No--(none/no more) at all"))
  data$T2563500 <- factor(data$T2563500, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("Yes",
      "Didn't matter",
      "No--not at that time",
      "No--(none/no more) at all"))
  data$T3547400 <- factor(data$T3547400, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("Yes",
      "Didn't matter",
      "No--not at that time",
      "No--(none/no more) at all"))
  data$T3547500 <- factor(data$T3547500, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("Yes",
      "Didn't matter",
      "No--not at that time",
      "No--(none/no more) at all"))
  data$T4521300 <- factor(data$T4521300, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("Yes",
      "Didn't matter",
      "No--not at that time",
      "No--(none/no more) at all"))
  data$T4521400 <- factor(data$T4521400, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("Yes",
      "Didn't matter",
      "No--not at that time",
      "No--(none/no more) at all"))
  data$T4521500 <- factor(data$T4521500, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("Yes",
      "Didn't matter",
      "No--not at that time",
      "No--(none/no more) at all"))
  data$T4521600 <- factor(data$T4521600, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("Yes",
      "Didn't matter",
      "No--not at that time",
      "No--(none/no more) at all"))
  data$T4521700 <- factor(data$T4521700, 
    levels=c(1.0,2.0,3.0,4.0), 
    labels=c("Yes",
      "Didn't matter",
      "No--not at that time",
      "No--(none/no more) at all"))
  return(data)
}

varlabels <- c("ID# (1-12686) 79",
  "F WANT BE PREG B4 PREG#1 82",
  "F HUSBAND/PARTNER WANT PREG#1 82",
  "F WANT BE PREG B4 PREG#2 82",
  "F HUSBAND/PARTNER WANT PREG#2 82",
  "F WANT BE PREG B4 PREG#3 82",
  "F HUSBAND/PARTNER WANT PREG#3 82",
  "F WANT BE PREG B4 PREG#4 82",
  "F HUSBAND/PARTNER WANT PREG#4 82",
  "F WANT BE PREG B4 PREG#5 82",
  "F HUSBAND/PARTNER WANT PREG#5 82",
  "F WANT BE PREG B4 PREG#6 82",
  "F HUSBAND/PARTNER WANT PREG#6 82",
  "F WANT BE PREG B4 PREG#7 82",
  "F HUSBAND/PARTNER WANT PREG#7 82",
  "F WANT BE PREG B4 PREG#1 83",
  "F HUSBAND/PARTNER WANT PREG#1 83",
  "F WANT BE PREG B4 PREG#2 83",
  "F HUSBAND/PARTNER WANT PREG#2 83",
  "F WANT BE PREG B4 PREG#3 83",
  "F HUSBAND/PARTNER WANT PREG#3 83",
  "F WANT BE PREG B4 PREG#4 83",
  "F HUSBAND/PARTNER WANT PREG#4 83",
  "F WANT BE PREG B4 PREG#5 83",
  "F HUSBAND/PARTNER WANT PREG#5 83",
  "F WANT BE PREG B4 PREG#1 84",
  "F HUSBAND/PARTNER WANT PREG#1 84",
  "F WANT BE PREG B4 PREG#2 84",
  "F HUSBAND/PARTNER WANT PREG#2 84",
  "F HUSBAND/PARTNER WANT PREG#3 84",
  "F WANT BE PREG B4 PREG#4 84",
  "F HUSBAND/PARTNER WANT PREG#4 84",
  "F WANT BE PREG B4 PREG#1 85",
  "F HUSBAND/PARTNER WANT PREG#1 85",
  "F WANT BE PREG B4 PREG#2 85",
  "F HUSBAND/PARTNER WANT PREG#2 85",
  "F WANT BE PREG B4 PREG#3 85",
  "F HUSBAND/PARTNER WANT PREG#3 85",
  "F WANT BE PREG B4 PREG#1 86",
  "F HUSBAND/PARTNER WANT PREG#1 86",
  "F WANT BE PREG B4 PREG#2 86",
  "F HUSBAND/PARTNER WANT PREG#2 86",
  "F WANT BE PREG B4 PREG#1 88",
  "F HUSBAND/PARTNER WANT PREG#1 88",
  "F WANT BE PREG B4 PREG#2 88",
  "F HUSBAND/PARTNER WANT PREG#2 88",
  "F WANT BE PREG B4 PREG#3 88",
  "F HUSBAND/PARTNER WANT PREG#3 88",
  "F WANT BE PREG B4 PREG#1 90",
  "F HUSBAND/PARTNER WANT PREG#1 90",
  "F WANT BE PREG B4 PREG#2 90",
  "F HUSBAND/PARTNER WANT PREG#2 90",
  "F WANT BE PREG B4 PREG#3 90",
  "F HUSBAND/PARTNER WANT PREG#3 90",
  "F WANT BE PREG B4 PREG#1 LIVE BIRTH 92",
  "F HUSBAND/PARTNER WANT PREG#1 LIVE 92",
  "F WANT BE PREG B4 PREG#2 LIVE BIRTH 92",
  "F HUSBAND/PARTNER WANT PREG#1 LIVE 92",
  "DID YOU WANT TO BECOME PREGNANT 94",
  "DID SP WANT YOU TO BECOME PREGNANT 94",
  "YOU WANT TO BECOME PREGNANT WHEN DID 94",
  "DID SP WANT YOU TO BECOME PREGNANT 94",
  "YOU WANT BECOME PREGNANT WHEN DID 1ST 96",
  "DID SP WANT YOU TO BECOME PREGNANT 1 96",
  "YOU WANT BECOME PREGNANT WHEN DID 2ND 96",
  "DID SP WANT YOU TO BECOME PREGNANT 2 96",
  "R WANT TO BECOME PREGNANT? L1 1998",
  "R WANT TO BECOME PREGNANT? L2 1998",
  "SP WANT YOU TO BECOME PREGNANT? L1 1998",
  "SP WANT YOU TO BECOME PREGNANT? L2 1998",
  "R WANT TO BECOME PREGNANT? L1 2000",
  "R WANT TO BECOME PREGNANT? L2 2000",
  "SP WANT YOU TO BECOME PREGNANT? L1 2000",
  "SP WANT YOU TO BECOME PREGNANT? L2 2000",
  "R WANT TO BECOME PREGNANT? L1 2002",
  "R WANT TO BECOME PREGNANT? L2 2002",
  "R WANT TO BECOME PREGNANT? L3 2002",
  "R WANT TO BECOME PREGNANT? L4 2002",
  "R WANT TO BECOME PREGNANT? L5 2002",
  "R WANT TO BECOME PREGNANT? L6 2002",
  "R WANT TO BECOME PREGNANT? L8 2002",
  "R WANT TO BECOME PREGNANT? L9 2002",
  "SP WANT YOU TO BECOME PREGNANT? L1 2002",
  "SP WANT YOU TO BECOME PREGNANT? L2 2002",
  "SP WANT YOU TO BECOME PREGNANT? L3 2002",
  "SP WANT YOU TO BECOME PREGNANT? L4 2002",
  "SP WANT YOU TO BECOME PREGNANT? L5 2002",
  "SP WANT YOU TO BECOME PREGNANT? L6 2002",
  "SP WANT YOU TO BECOME PREGNANT? L7 2002",
  "SP WANT YOU TO BECOME PREGNANT? L8 2002",
  "SP WANT YOU TO BECOME PREGNANT? L9 2002",
  "R WANT TO BECOME PREGNANT? L1 2004",
  "R WANT TO BECOME PREGNANT? L2 2004",
  "R WANT TO BECOME PREGNANT? L3 2004",
  "R WANT TO BECOME PREGNANT? L4 2004",
  "R WANT TO BECOME PREGNANT? L10 2004",
  "SP WANT YOU TO BECOME PREGNANT? L1 2004",
  "SP WANT YOU TO BECOME PREGNANT? L2 2004",
  "SP WANT YOU TO BECOME PREGNANT? L3 2004",
  "SP WANT YOU TO BECOME PREGNANT? L4 2004",
  "SP WANT YOU TO BECOME PREGNANT? L5 2004",
  "SP WANT YOU TO BECOME PREGNANT? L6 2004",
  "SP WANT YOU TO BECOME PREGNANT? L10 2004",
  "R WANT TO BECOME PREGNANT? L1 2006",
  "R WANT TO BECOME PREGNANT? L2 2006",
  "R WANT TO BECOME PREGNANT? L3 2006",
  "R WANT TO BECOME PREGNANT? L4 2006",
  "R WANT TO BECOME PREGNANT? L5 2006",
  "SP WANT YOU TO BECOME PREGNANT? L1 2006",
  "SP WANT YOU TO BECOME PREGNANT? L2 2006",
  "SP WANT YOU TO BECOME PREGNANT? L3 2006",
  "SP WANT YOU TO BECOME PREGNANT? L4 2006",
  "SP WANT YOU TO BECOME PREGNANT? L5 2006",
  "R WANT TO BECOME PREGNANT? L2 2008",
  "R WANT TO BECOME PREGNANT? L3 2008",
  "R WANT TO BECOME PREGNANT? L4 2008",
  "R WANT TO BECOME PREGNANT? L5 2008",
  "R WANT TO BECOME PREGNANT? L6 2008",
  "R WANT TO BECOME PREGNANT? L9 2008",
  "SP WANT YOU TO BECOME PREGNANT? L1 2008",
  "SP WANT YOU TO BECOME PREGNANT? L2 2008",
  "SP WANT YOU TO BECOME PREGNANT? L3 2008",
  "SP WANT YOU TO BECOME PREGNANT? L4 2008",
  "SP WANT YOU TO BECOME PREGNANT? L5 2008",
  "SP WANT YOU TO BECOME PREGNANT? L6 2008",
  "SP WANT YOU TO BECOME PREGNANT? L9 2008",
  "R WANT TO BECOME PREGNANT? L1 2010",
  "R WANT TO BECOME PREGNANT? L3 2010",
  "R WANT TO BECOME PREGNANT? L5 2010",
  "SP WANT YOU TO BECOME PREGNANT? L1 2010",
  "SP WANT YOU TO BECOME PREGNANT? L2 2010",
  "SP WANT YOU TO BECOME PREGNANT? L3 2010",
  "SP WANT YOU TO BECOME PREGNANT? L5 2010",
  "SP WANT YOU TO BECOME PREGNANT? L1 2012",
  "SP WANT YOU TO BECOME PREGNANT? L2 2012",
  "R WANT TO BECOME PREGNANT? L4 2014",
  "SP WANT YOU TO BECOME PREGNANT? L1 2014",
  "SP WANT YOU TO BECOME PREGNANT? L2 2014",
  "SP WANT YOU TO BECOME PREGNANT? L3 2014",
  "SP WANT YOU TO BECOME PREGNANT? L4 2014"
)


# Use qnames rather than rnums

qnames = function(data) {
  names(data) <- c("CASEID_1979",
    "Q9-81_1_1982",
    "Q9-82_1_1982",
    "Q9-81_2_1982",
    "Q9-82_2_1982",
    "Q9-81_3_1982",
    "Q9-82_3_1982",
    "Q9-81_4_1982",
    "Q9-82_4_1982",
    "Q9-81_5_1982",
    "Q9-82_5_1982",
    "Q9-81_6_1982",
    "Q9-82_6_1982",
    "Q9-81_7_1982",
    "Q9-82_7_1982",
    "Q9-81_1_1983",
    "Q9-82_1_1983",
    "Q9-81_2_1983",
    "Q9-82_2_1983",
    "Q9-81_3_1983",
    "Q9-82_3_1983",
    "Q9-81_4_1983",
    "Q9-82_4_1983",
    "Q9-81_5_1983",
    "Q9-82_5_1983",
    "Q9-81_1_1984",
    "Q9-82_1_1984",
    "Q9-81_2_1984",
    "Q9-82_2_1984",
    "Q9-82_3_1984",
    "Q9-81_4_1984",
    "Q9-82_4_1984",
    "Q9-81_1_1985",
    "Q9-82_1_1985",
    "Q9-81_2_1985",
    "Q9-82_2_1985",
    "Q9-81_3_1985",
    "Q9-82_3_1985",
    "Q9-81_1_1986",
    "Q9-82_1_1986",
    "Q9-81_2_1986",
    "Q9-82_2_1986",
    "Q9-81_1_1988",
    "Q9-82_1_1988",
    "Q9-81_2_1988",
    "Q9-82_2_1988",
    "Q9-81_3_1988",
    "Q9-82_3_1988",
    "Q9-81_1_1990",
    "Q9-82_1_1990",
    "Q9-81_2_1990",
    "Q9-82_2_1990",
    "Q9-81_3_1990",
    "Q9-82_3_1990",
    "Q9-81_1_1992",
    "Q9-82_1_1992",
    "Q9-81_2_1992",
    "Q9-82_2_1992",
    "Q9-81.1_1994",
    "Q9-82.1_1994",
    "Q9-81.2_1994",
    "Q9-82.2_1994",
    "Q9-81.01_1996",
    "Q9-82.01_1996",
    "Q9-81.02_1996",
    "Q9-82.02_1996",
    "Q9-81.01_1998",
    "Q9-81.02_1998",
    "Q9-82.01_1998",
    "Q9-82.02_1998",
    "Q9-81.01_2000",
    "Q9-81.02_2000",
    "Q9-82.01_2000",
    "Q9-82.02_2000",
    "Q9-81.01_2002",
    "Q9-81.02_2002",
    "Q9-81.03_2002",
    "Q9-81.04_2002",
    "Q9-81.05_2002",
    "Q9-81.06_2002",
    "Q9-81.08_2002",
    "Q9-81.09_2002",
    "Q9-82.01_2002",
    "Q9-82.02_2002",
    "Q9-82.03_2002",
    "Q9-82.04_2002",
    "Q9-82.05_2002",
    "Q9-82.06_2002",
    "Q9-82.07_2002",
    "Q9-82.08_2002",
    "Q9-82.09_2002",
    "Q9-81.01_2004",
    "Q9-81.02_2004",
    "Q9-81.03_2004",
    "Q9-81.04_2004",
    "Q9-81.10_2004",
    "Q9-82.01_2004",
    "Q9-82.02_2004",
    "Q9-82.03_2004",
    "Q9-82.04_2004",
    "Q9-82.05_2004",
    "Q9-82.06_2004",
    "Q9-82.10_2004",
    "Q9-81.01_2006",
    "Q9-81.02_2006",
    "Q9-81.03_2006",
    "Q9-81.04_2006",
    "Q9-81.05_2006",
    "Q9-82.01_2006",
    "Q9-82.02_2006",
    "Q9-82.03_2006",
    "Q9-82.04_2006",
    "Q9-82.05_2006",
    "Q9-81.02_2008",
    "Q9-81.03_2008",
    "Q9-81.04_2008",
    "Q9-81.05_2008",
    "Q9-81.06_2008",
    "Q9-81.09_2008",
    "Q9-82.01_2008",
    "Q9-82.02_2008",
    "Q9-82.03_2008",
    "Q9-82.04_2008",
    "Q9-82.05_2008",
    "Q9-82.06_2008",
    "Q9-82.09_2008",
    "Q9-81.01_2010",
    "Q9-81.03_2010",
    "Q9-81.05_2010",
    "Q9-82.01_2010",
    "Q9-82.02_2010",
    "Q9-82.03_2010",
    "Q9-82.05_2010",
    "Q9-82.01_2012",
    "Q9-82.02_2012",
    "Q9-81.04_2014",
    "Q9-82.01_2014",
    "Q9-82.02_2014",
    "Q9-82.03_2014",
    "Q9-82.04_2014")
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

