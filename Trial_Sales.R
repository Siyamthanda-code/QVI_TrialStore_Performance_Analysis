> setwd("C:/Users/Amooo/Videos/Quantium_Forage/Task2")
> get()
Error in get() : argument "x" is missing, with no default
> getwd()
[1] "C:/Users/Amooo/Videos/Quantium_Forage/Task2"
> # -------------------------------------------------
> # 0. SETUP AND LOAD DATA
> # -------------------------------------------------
> # Load libraries
> library(data.table)
Error in library(data.table) : there is no package called ‘data.table’
> library(ggplot2)
Want to understand how all the pieces fit together? Read R for Data
Science: https://r4ds.hadley.nz/
Warning message:
package ‘ggplot2’ was built under R version 4.5.3 
> library(lubridate)

Attaching package: ‘lubridate’

The following objects are masked from ‘package:base’:

    date, intersect, setdiff, union

Warning message:
package ‘lubridate’ was built under R version 4.5.3 
> 
> # Set the working directory to your Task 2 folder
> setwd("C:/Users/Amooo/Videos/Quantium_Forage/Task2")
> 
> # Load the full dataset from Task 1
> full_data <- fread("QVI_data.csv")
Error in fread("QVI_data.csv") : could not find function "fread"
> 
> # Let's look at the data to confirm
> head(full_data)
Error: object 'full_data' not found
> 
> # Create a YEARMONTH column for easy grouping
> full_data[, YEARMONTH := format(DATE, "%Y%m")]
Error: object 'full_data' not found
> 
> # Calculate monthly metrics for each store
> store_monthly_metrics <- full_data[, .(
+   total_sales = sum(TOT_SALES),
+   total_customers = uniqueN(LYLTY_CARD_NBR),
+   total_transactions = uniqueN(TXN_ID)
+ ), by = .(STORE_NBR, YEARMONTH)]
Error: object 'full_data' not found
> 
> # Calculate transactions per customer
> store_monthly_metrics[, transactions_per_customer := total_transactions / total_customers]
Error: object 'store_monthly_metrics' not found
> 
> # Let's look at our new table of monthly metrics
> head(store_monthly_metrics)
Error: object 'store_monthly_metrics' not found
>install.packages("data.table") 
Error in nstall.packages("data.table") : 
  could not find function "nstall.packages"
> install.packages("data.table")
Installing package into ‘C:/Users/Amooo/AppData/Local/R/win-library/4.5’
(as ‘lib’ is unspecified)
--- Please select a CRAN mirror for use in this session ---
trying URL 'https://cloud.r-project.org/bin/windows/contrib/4.5/data.table_1.18.2.1.zip'
Content type 'application/zip' length 3200143 bytes (3.1 MB)
downloaded 3.1 MB

package ‘data.table’ successfully unpacked and MD5 sums checked

The downloaded binary packages are in
        C:\Users\Amooo\AppData\Local\Temp\RtmpU1Oam1\downloaded_packages
> # -------------------------------------------------
> # 0. SETUP AND LOAD DATA
> # -------------------------------------------------
> # Load libraries (now that data.table is installed)
> library(data.table)
data.table 1.18.2.1 using 2 threads (see ?getDTthreads).  Latest news: r-datatable.com

Attaching package: ‘data.table’

The following objects are masked from ‘package:lubridate’:

    hour, isoweek, isoyear, mday, minute, month, quarter, second, wday, week, yday, year

Warning message:
package ‘data.table’ was built under R version 4.5.3 
> library(ggplot2)
> library(lubridate)
> 
> # Set the working directory to your Task 2 folder
> setwd("C:/Users/Amooo/Videos/Quantium_Forage/Task2")
> 
> # Load the full dataset from Task 1
> full_data <- fread("QVI_data.csv")
> 
> # Let's look at the data to confirm
> head(full_data)
   LYLTY_CARD_NBR       DATE STORE_NBR TXN_ID PROD_NBR                              PROD_NAME PROD_QTY TOT_SALES PACK_SIZE      BRAND              LIFESTAGE
            <int>     <IDat>     <int>  <int>    <int>                                 <char>    <int>     <num>     <int>     <char>                 <char>
1:           1000 2018-10-17         1      1        5 Natural Chip        Compny SeaSalt175g        2       6.0       175    NATURAL  YOUNG SINGLES/COUPLES
2:           1002 2018-09-16         1      2       58  Red Rock Deli Chikn&Garlic Aioli 150g        1       2.7       150        RRD  YOUNG SINGLES/COUPLES
3:           1003 2019-03-07         1      3       52  Grain Waves Sour    Cream&Chives 210G        1       3.6       210    GRNWVES         YOUNG FAMILIES
4:           1003 2019-03-08         1      4      106 Natural ChipCo      Hony Soy Chckn175g        1       3.0       175    NATURAL         YOUNG FAMILIES
5:           1004 2018-11-02         1      5       96         WW Original Stacked Chips 160g        1       1.9       160 WOOLWORTHS  OLDER SINGLES/COUPLES
6:           1005 2018-12-28         1      6       86                     Cheetos Puffs 165g        1       2.8       165    CHEETOS MIDAGE SINGLES/COUPLES
   PREMIUM_CUSTOMER
             <char>
1:          Premium
2:       Mainstream
3:           Budget
4:           Budget
5:       Mainstream
6:       Mainstream
> 
> # Create a YEARMONTH column for easy grouping
> full_data[, YEARMONTH := format(DATE, "%Y%m")]
> 
> # Calculate monthly metrics for each store
> store_monthly_metrics <- full_data[, .(
+   total_sales = sum(TOT_SALES),
+   total_customers = uniqueN(LYLTY_CARD_NBR),
+   total_transactions = uniqueN(TXN_ID)
+ ), by = .(STORE_NBR, YEARMONTH)]
> 
> # Calculate transactions per customer
> store_monthly_metrics[, transactions_per_customer := total_transactions / total_customers]
> 
> # Let's look at our new table of monthly metrics
> head(store_monthly_metrics)
   STORE_NBR YEARMONTH total_sales total_customers total_transactions transactions_per_customer
       <int>    <char>       <num>           <int>              <int>                     <num>
1:         1    201810       188.1              44                 45                  1.022727
2:         1    201809       278.8              59                 62                  1.050847
3:         1    201903       192.9              45                 49                  1.088889
4:         1    201811       192.6              46                 47                  1.021739
5:         1    201812       189.6              42                 47                  1.119048
6:         1    201807       206.9              49                 52                  1.061224
> # -------------------------------------------------
> # 1. FUNCTION TO FIND CONTROL STORE
> # -------------------------------------------------
> find_control_store <- function(trial_store_number, pre_trial_data) {
+   
+   # Get the metrics for our trial store (averages over the pre-trial period)
+   trial_store_metrics <- pre_trial_data[STORE_NBR == trial_store_number, .(avg_sales = mean(total_sales), avg_customers = mean(total_customers), avg_trans_per_cust = mean(transactions_per_customer))]
+   
+   # Get the metrics for all potential control stores (excluding trial stores)
+   control_stores_metrics <- pre_trial_data[!STORE_NBR %in% c(77, 86, 88), .(STORE_NBR, avg_sales = mean(total_sales), avg_customers = mean(total_customers), avg_trans_per_cust = mean(transactions_per_customer)), by = STORE_NBR]
+   
+   # Calculate a simple magnitude distance for each metric
+   # The smaller the distance, the more similar the stores are
+   calculate_distance <- function(x, y) {
+     abs(x - y) / (max(y) - min(y))
+   }
+   
+   # Combine metrics into a single composite score (the lower, the better)
+   control_stores_metrics[, sales_dist := calculate_distance(trial_store_metrics$avg_sales, avg_sales)]
+   control_stores_metrics[, cust_dist := calculate_distance(trial_store_metrics$avg_customers, avg_customers)]
+   control_stores_metrics[, trans_dist := calculate_distance(trial_store_metrics$avg_trans_per_cust, avg_trans_per_cust)]
+   
+   control_stores_metrics[, composite_score := (sales_dist + cust_dist + trans_dist) / 3]
+   
+   # Find the store with the minimum composite score
+   best_control_store <- control_stores_metrics[order(composite_score)][1]
+   
+   return(best_control_store$STORE_NBR)
+ }
> 
> 
> # -------------------------------------------------
> # 2. FIND THE BEST CONTROL STORE FOR EACH TRIAL STORE
> # -------------------------------------------------
> # Define the pre-trial period data (before Feb 2019)
> pre_trial_data <- store_monthly_metrics[YEARMONTH < "201902"]
> 
> # Find control for Trial Store 77
> control_store_77 <- find_control_store(77, pre_trial_data)
> cat("The best control store for trial store 77 is:", control_store_77, "\n")
The best control store for trial store 77 is: 268 
> 
> # Find control for Trial Store 86
> control_store_86 <- find_control_store(86, pre_trial_data)
> cat("The best control store for trial store 86 is:", control_store_86, "\n")
The best control store for trial store 86 is: 225 
> 
> # Find control for Trial Store 88
> control_store_88 <- find_control_store(88, pre_trial_data)
> cat("The best control store for trial store 88 is:", control_store_88, "\n")
The best control store for trial store 88 is: 237 
># ------------------------------------------------- 
+ # 3. VISUALIZE THE PRE-TRIAL MATCH FOR ALL STORES
+ # -------------------------------------------------
+ 
+ # --- Visualize for Trial Store 77 ---
+ plot_data_77 <- store_monthly_metrics[STORE_NBR %in% c(77, 268) & YEARMONTH < "201902"]
Error: object 'plot_data_77' not found
> plot_data_77[, STORE_TYPE := ifelse(STORE_NBR == 77, "Trial 77", "Control 268")]
Error: object 'plot_data_77' not found
> 
> ggplot(plot_data_77, aes(x = YEARMONTH, y = total_sales, color = STORE_TYPE, group = STORE_TYPE)) +
+   geom_line(linewidth = 1) +
+   geom_point(size = 2) +
+   labs(title = "Pre-Trial Sales: Trial Store 77 vs Control Store 268",
+        x = "Month",
+        y = "Total Sales") +
+   theme_minimal() +
+   scale_x_discrete(labels = c("Jul '18", "Aug '18", "Sep '18", "Oct '18", "Nov '18", "Dec '18", "Jan '19"))
Error: object 'plot_data_77' not found
> 
> 
> # --- Visualize for Trial Store 86 ---
> plot_data_86 <- store_monthly_metrics[STORE_NBR %in% c(86, 225) & YEARMONTH < "201902"]
> plot_data_86[, STORE_TYPE := ifelse(STORE_NBR == 86, "Trial 86", "Control 225")]
> 
> ggplot(plot_data_86, aes(x = YEARMONTH, y = total_sales, color = STORE_TYPE, group = STORE_TYPE)) +
+   geom_line(linewidth = 1) +
+   geom_point(size = 2) +
+   labs(title = "Pre-Trial Sales: Trial Store 86 vs Control Store 225",
+        x = "Month",
+        y = "Total Sales") +
+   theme_minimal() +
+   scale_x_discrete(labels = c("Jul '18", "Aug '18", "Sep '18", "Oct '18", "Nov '18", "Dec '18", "Jan '19"))
> 
> 
> # --- Visualize for Trial Store 88 ---
> plot_data_88 <- store_monthly_metrics[STORE_NBR %in% c(88, 237) & YEARMONTH < "201902"]
> plot_data_88[, STORE_TYPE := ifelse(STORE_NBR == 88, "Trial 88", "Control 237")]
> 
> ggplot(plot_data_88, aes(x = YEARMONTH, y = total_sales, color = STORE_TYPE, group = STORE_TYPE)) +
+   geom_line(linewidth = 1) +
+   geom_point(size = 2) +
+   labs(title = "Pre-Trial Sales: Trial Store 88 vs Control Store 237",
+        x = "Month",
+        y = "Total Sales") +
+   theme_minimal() +
+   scale_x_discrete(labels = c("Jul '18", "Aug '18", "Sep '18", "Oct '18", "Nov '18", "Dec '18", "Jan '19"))
> # -------------------------------------------------
> # FIX: Convert YEARMONTH to a number for reliable comparisons
> # -------------------------------------------------
> store_monthly_metrics[, YEARMONTH := as.numeric(YEARMONTH)]
> 
> 
> # -------------------------------------------------
> # 3. VISUALIZE THE PRE-TRIAL MATCH FOR ALL STORES
> # -------------------------------------------------
> 
> # --- Visualize for Trial Store 77 ---
> plot_data_77 <- store_monthly_metrics[STORE_NBR %in% c(77, 268) & YEARMONTH < 201902]
> plot_data_77[, STORE_TYPE := ifelse(STORE_NBR == 77, "Trial 77", "Control 268")]
> 
> ggplot(plot_data_77, aes(x = factor(YEARMONTH), y = total_sales, color = STORE_TYPE, group = STORE_TYPE)) +
+   geom_line(linewidth = 1) +
+   geom_point(size = 2) +
+   labs(title = "Pre-Trial Sales: Trial Store 77 vs Control Store 268",
+        x = "Month",
+        y = "Total Sales") +
+   theme_minimal() +
+   scale_x_discrete(labels = c("Jul '18", "Aug '18", "Sep '18", "Oct '18", "Nov '18", "Dec '18", "Jan '19"))
> 
> 
> # --- Visualize for Trial Store 86 ---
> plot_data_86 <- store_monthly_metrics[STORE_NBR %in% c(86, 225) & YEARMONTH < 201902]
> plot_data_86[, STORE_TYPE := ifelse(STORE_NBR == 86, "Trial 86", "Control 225")]
> 
> ggplot(plot_data_86, aes(x = factor(YEARMONTH), y = total_sales, color = STORE_TYPE, group = STORE_TYPE)) +
+   geom_line(linewidth = 1) +
+   geom_point(size = 2) +
+   labs(title = "Pre-Trial Sales: Trial Store 86 vs Control Store 225",
+        x = "Month",
+        y = "Total Sales") +
+   theme_minimal() +
+   scale_x_discrete(labels = c("Jul '18", "Aug '18", "Sep '18", "Oct '18", "Nov '18", "Dec '18", "Jan '19"))
> 
> 
> # --- Visualize for Trial Store 88 ---
> plot_data_88 <- store_monthly_metrics[STORE_NBR %in% c(88, 237) & YEARMONTH < 201902]
> plot_data_88[, STORE_TYPE := ifelse(STORE_NBR == 88, "Trial 88", "Control 237")]
> 
> ggplot(plot_data_88, aes(x = factor(YEARMONTH), y = total_sales, color = STORE_TYPE, group = STORE_TYPE)) +
+   geom_line(linewidth = 1) +
+   geom_point(size = 2) +
+   labs(title = "Pre-Trial Sales: Trial Store 88 vs Control Store 237",
+        x = "Month",
+        y = "Total Sales") +
+   theme_minimal() +
+   scale_x_discrete(labels = c("Jul '18", "Aug '18", "Sep '18", "Oct '18", "Nov '18", "Dec '18", "Jan '19"))
> 
> 
> # -------------------------------------------------
> # 4. ASSESS TRIAL IMPACT FOR ALL STORES
> # -------------------------------------------------
> 
> # Define the trial period data (Feb 2019 to Apr 2019)
> trial_period_data <- store_monthly_metrics[YEARMONTH >= 201902 & YEARMONTH <= 201904]
> 
> # --- Assess Trial Store 77 ---
> assessment_data_77 <- trial_period_data[STORE_NBR %in% c(77, 268)]
> assessment_data_77[, STORE_TYPE := ifelse(STORE_NBR == 77, "Trial 77", "Control 268")]
> 
> ggplot(assessment_data_77, aes(x = factor(YEARMONTH), y = total_sales, fill = STORE_TYPE)) +
+   geom_col(position = "dodge") +
+   labs(title = "Sales During Trial: Store 77 vs Control Store 268",
+        x = "Month",
+        y = "Total Sales") +
+   theme_minimal() +
+   scale_x_discrete(labels = c("Feb '19", "Mar '19", "Apr '19"))
> 
> # Calculate the percentage difference for Store 77
> trial_sales_77 <- assessment_data_77[STORE_TYPE == "Trial 77", sum(total_sales)]
> control_sales_77 <- assessment_data_77[STORE_TYPE == "Control 268", sum(total_sales)]
> percentage_diff_77 <- ((trial_sales_77 - control_sales_77) / control_sales_77) * 100
> cat("Percentage difference in total sales during trial for store 77:", round(percentage_diff_77, 2), "%\n")
Percentage difference in total sales during trial for store 77: 33.62 %
> 
> 
> # --- Assess Trial Store 86 ---
> assessment_data_86 <- trial_period_data[STORE_NBR %in% c(86, 225)]
> assessment_data_86[, STORE_TYPE := ifelse(STORE_NBR == 86, "Trial 86", "Control 225")]
> 
> ggplot(assessment_data_86, aes(x = factor(YEARMONTH), y = total_sales, fill = STORE_TYPE)) +
+   geom_col(position = "dodge") +
+   labs(title = "Sales During Trial: Store 86 vs Control Store 225",
+        x = "Month",
+        y = "Total Sales") +
+   theme_minimal() +
+   scale_x_discrete(labels = c("Feb '19", "Mar '19", "Apr '19"))
> 
> # Calculate the percentage difference for Store 86
> trial_sales_86 <- assessment_data_86[STORE_TYPE == "Trial 86", sum(total_sales)]
> control_sales_86 <- assessment_data_86[STORE_TYPE == "Control 225", sum(total_sales)]
> percentage_diff_86 <- ((trial_sales_86 - control_sales_86) / control_sales_86) * 100
> cat("Percentage difference in total sales during trial for store 86:", round(percentage_diff_86, 2), "%\n")
Percentage difference in total sales during trial for store 86: 5.69 %
> 
> 
> # --- Assess Trial Store 88 ---
> assessment_data_88 <- trial_period_data[STORE_NBR %in% c(88, 237)]
> assessment_data_88[, STORE_TYPE := ifelse(STORE_NBR == 88, "Trial 88", "Control 237")]
> 
> ggplot(assessment_data_88, aes(x = factor(YEARMONTH), y = total_sales, fill = STORE_TYPE)) +
+   geom_col(position = "dodge") +
+   labs(title = "Sales During Trial: Store 88 vs Control Store 237",
+        x = "Month",
+        y = "Total Sales") +
+   theme_minimal() +
+   scale_x_discrete(labels = c("Feb '19", "Mar '19", "Apr '19"))
> 
> # Calculate the percentage difference for Store 88
> trial_sales_88 <- assessment_data_88[STORE_TYPE == "Trial 88", sum(total_sales)]
> control_sales_88 <- assessment_data_88[STORE_TYPE == "Control 237", sum(total_sales)]
> percentage_diff_88 <- ((trial_sales_88 - control_sales_88) / control_sales_88) * 100
> cat("Percentage difference in total sales during trial for store 88:", round(percentage_diff_88, 2), "%\n")
Percentage difference in total sales during trial for store 88: 12.29 %
> cat("Percentage difference in total sales during trial for store 88:", round(percentage_diff_88, 2), "%\n")
Percentage difference in total sales during trial for store 88: 12.29 %
> cat("Percentage difference in total sales during trial for store 88:", round(percentage_diff_88, 2), "%\n")
Percentage difference in total sales during trial for store 88: 12.29 %
