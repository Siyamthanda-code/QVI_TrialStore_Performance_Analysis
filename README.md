# QVI Trial Store Performance Analysis 📈

## Project Overview
This project evaluates the effectiveness of a new in-store layout trial conducted across three selected stores. The primary objective was to determine if the new layout design led to a statistically significant increase in sales compared to a baseline. By identifying suitable control stores and analyzing performance lifts, the project delivers data-driven recommendations regarding a potential company-wide rollout.

## The Trial
*   **Trial Stores:** 77, 86, 88
*   **Trial Period:** February 2019 – April 2019
*   **Pre-Trial Baseline:** July 2018 – January 2019

## Data Source
The analysis utilizes the full QVI transaction dataset.

**Note:** The `QVI_data.csv` file exceeds 25MB and is not included in this repository.

## Methodology
1.  **Data Preparation:** Monthly performance metrics (total sales, customer count, and transactions) were aggregated from the QVI dataset.
2.  **Control Store Selection:** For each trial store, a matching control store was identified based on similarity in pre-trial performance. Selection was based on a composite score calculating the magnitude distance of sales, customer count, and transactions per customer.
3.  **Impact Assessment:** The total sales of each trial store were compared against its respective control store during the trial period to quantify the percentage lift.

## Repository Structure
```text
.
├── trial_analysis.R               # R script for analysis and visualization
├── README.md                      # Project documentation
└── plots/                         # Generated visualization files
```

## Tools & Requirements
*   **Language:** R (version 4.5.x)
*   **Libraries:** `data.table`, `ggplot2`, `lubridate`

## How to Run
1.  Clone this repository to your local machine.
2.  Open `trial_analysis.R` in RStudio.
3.  Set the working directory:
    ```r
    setwd("path/to/your/repository")
    ```
4.  Install required packages if necessary:
    ```r
    install.packages(c("data.table", "ggplot2", "lubridate"))
    ```
5.  Run the script. It will identify control stores, generate comparative visualizations, and output the performance lift for each trial store.

## Key Findings
### Control Store Matching
*   **Store 77** matched with Control Store 268
*   **Store 86** matched with Control Store 225
*   **Store 88** matched with Control Store 237

### Performance Results
The trial layout yielded positive results across all locations:

| Trial Store | Control Store | Sales Lift |
| :--- | :--- | :--- |
| **77** | 268 | **+33.62%** |
| **86** | 225 | **+5.69%** |
| **88** | 237 | **+12.29%** |

## Recommendation
**Proceed with a full-scale rollout.**
The consistent and significant positive sales lift observed across all three trial stores provides strong evidence that the new layout effectively drives revenue. A company-wide implementation is recommended to maximize growth in the chip category.

## Author
**Siyamthanda Amahle Buthelezi**
