# Data variables
training.file   <- './data/pml-training.csv'
test.cases.file <- './data/pml-testing.csv'
training.url    <- 'http://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv'
test.cases.url  <- 'http://d396qusza40orc.cloudfront.net/predmachlearn/pml-testing.csv'

# Directories
if (!file.exists("data")){
  dir.create("data")
}
if (!file.exists("data/submission")){
  dir.create("data/submission")
}

# R-Packages
required_packages <- c("caret", "randomForest", "rpart", "rpart.plot")
new_packages <- required_packages[!(required_packages %in% installed.packages()[,"Package"])]
if(length(new_packages)) install.packages(new_packages)

# Load packages
lapply(required_packages, library, character.only = TRUE)
# Set seed for reproducibility
set.seed(9999)
# Download data
download.file(training.url, training.file)
download.file(test.cases.url, test.cases.file)

# Clean data
training <- read.csv(training.file, na.strings=c("NA", "#DIV/0!", ""))
testing <- read.csv(test.cases.file, na.strings=c("NA", "#DIV/0!", ""))
training <- training[, colSums(is.na(training)) == 0]
testing <- testing[, colSums(is.na(testing)) == 0]

# Subset data
training <- training[, -c(1:7)]
testing <- testing[, -c(1:7)]
library(caret)  # Ensure caret is loaded for createDataPartition
subSamples <- createDataPartition(y=training$classe, p=0.75, list=FALSE)
subTraining <- training[subSamples, ] 
subTesting <- training[-subSamples, ]
# Check for missing values and print a summary
summary(subTraining$classe)
# Ensure 'classe' is a factor
subTraining$classe <- as.factor(subTraining$classe)

# Create a table of counts for each level of 'classe'
classe_counts <- table(subTraining$classe)

# Check the structure of subTraining
str(subTraining)
# Create bar plot with multiple colors
library(ggplot2)
print(levels(subTraining$classe))
# Define colors for each class
color_values <- c("A" = "magenta", 
                  "B" = "cyan", 
                  "C" = "yellow", 
                  "D" = "orange", 
                  "E" = "blue")

# Create the bar plot
ggplot(subTraining, aes(x=classe, fill=classe)) + 
  geom_bar() + 
  scale_fill_manual(values=color_values) +
  labs(title="Levels of the variable classe", 
       x="Classe Levels", 
       y="Frequency") +
  theme_minimal()
# Check structure of the data
str(subTraining)
# Convert factor columns to numeric if needed
# Make sure 'classe' is a factor
subTraining$classe <- as.factor(subTraining$classe)

# Identify non-numeric columns
non_numeric_cols <- sapply(subTraining, function(x) !is.numeric(x) && !is.factor(x))

if (any(non_numeric_cols)) {
  # Optionally, print non-numeric columns
  print(colnames(subTraining)[non_numeric_cols])
  
  # You can either convert these columns or remove them
  # Convert to numeric or handle appropriately
  # Here, we will remove non-numeric columns
  subTraining <- subTraining[, !non_numeric_cols]
}

# Fit model
modFitDT <- rpart(classe ~ ., data=subTraining, method="class")

# Perform prediction
predictDT <- predict(modFitDT, subTesting, type="class")

# Plot result
rpart.plot(modFitDT, main="Classification Tree", extra=102, under=TRUE, faclen=0)

# Fit model
modFitRF <- randomForest(classe ~ ., data=subTraining, method="class")

# Perform prediction
predictRF <- predict(modFitRF, subTesting, type = "class")

# Ensure both are factors and have the same levels
predictRF <- as.factor(predictRF)
subTesting$classe <- as.factor(subTesting$classe)

# Set levels to be the same
levels(predictRF) <- levels(subTesting$classe)

# Generate the confusion matrix
cm_rf <- confusionMatrix(predictRF, subTesting$classe)
print(cm_rf)
