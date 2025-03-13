/* Import dataset */
filename injury url "https://raw.githubusercontent.com/rachelnisbet/SAS-Procs-Oh-My/main/injury_data.csv";

proc import datafile=injury
    out=injury_data dbms= csv replace;
run;

/* PROC SQL: Using SQL queries */
proc sql;
  select *
  from injury_data
  where Player_Age > 35;
quit;

proc sql;
    select previous_injuries, recovery_time, mean(training_intensity) as Avg_Intensity
    from injury_data
    group by recovery_time, previous_injuries
    order by avg_intensity desc;
quit;

proc python;
submit;

import pandas as pd

# Read the SAS dataset into a pandas DataFrame
injury_df = pd.read_csv("https://raw.githubusercontent.com/rachelnisbet/SAS-Procs-Oh-My/main/injury_data.csv")

endsubmit;
run;

proc python;
submit;

# Filter data where Player_Age > 35 using Python
filtered_injury = injury_df[injury_df['Player_Age'] > 35]

# Print the filtered DataFrame
print(filtered_injury.head())

endsubmit;
run;

proc python;
submit;

# Calculate and print summary statistics
summary = injury_df.describe()
print(summary)

endsubmit;
run;

proc python;
submit;

# Calculate correlation matrix
correlation_matrix = injury_df.corr()

# Print correlation matrix
print("Correlation Matrix:")
print(correlation_matrix)

# Extract correlation with 'Likelihood_of_Injury' variable
likelihood_correlation = correlation_matrix['Likelihood_of_Injury']

# Print correlation with 'Likelihood_of_Injury'
print("\nCorrelation with Likelihood_of_Injury:")
print(likelihood_correlation)

endsubmit;
run;

/* PROC IML: Using the interactive matrix language */

proc iml;
submit / R;

# Read in the CSV file
injury_data <- read.csv("https://raw.githubusercontent.com/rachelnisbet/SAS-Procs-Oh-My/main/injury_data.csv")

# Verify our data was brought in
head(injury_data)

endsubmit;
run;

/* PROC IML: Using the interactive matrix language */

proc iml;
submit / R;

# Read in the CSV file
injury_data <- read.csv("https://raw.githubusercontent.com/rachelnisbet/SAS-Procs-Oh-My/main/injury_data.csv")

# Filter the data
filtered_data <- injury_data[injury_data$Player_Age >= 35, ]
 
# Print data
print(filtered_data)

endsubmit;
run;

/* PROC IML: Using the interactive matrix language */

proc iml;
submit / R;

# Read in the CSV file
injury_data <- read.csv("https://raw.githubusercontent.com/rachelnisbet/SAS-Procs-Oh-My/main/injury_data.csv")

# Summary statistics
summary_stats <- summary(injury_data)      

# Print summary statistics
print("Here comes summary stats....")
print(summary_stats)

endsubmit;
run;

/* PROC IML: Using the interactive matrix language */

proc iml;
submit / R;

# Read in the CSV file
injury_data <- read.csv("https://raw.githubusercontent.com/rachelnisbet/SAS-Procs-Oh-My/main/injury_data.csv")

# Define age groups (e.g., 17-25, 26-35, etc.)
age_breaks <- c(17, 25, 35, max(injury_data$Player_Age))
age_labels <- c("18-25", "26-35", "36+")
age_groups <- cut(injury_data$Player_Age, breaks = age_breaks, labels = age_labels)


# Add age groups as a new column in the dataset
injury_data$Age_Group <- age_groups

# Calculate and print frequencies for Age Group
summary_stats2 <- summary(injury_data$Age_Group)
print("Here comes Age Group freq counts....")
print(summary_stats2)

endsubmit;

run;


