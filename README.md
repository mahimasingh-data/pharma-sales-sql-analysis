# Pharma Sales Analysis (SQL)

## Business problem
A pharma company wants to know which drug categories drive sales, how sales change month to month, and when to plan stock and promotions.

## Dataset
Pharma Sales Data (monthly file) from Kaggle, 70 months of sales from January 2014. It covers 8 drug categories: M01AB, M01AE, N02BA, N02BE, N05B, N05C, R03 and R06.

## Approach
Cleaned the file in Excel (fixed the date format, renamed columns), loaded it into SQLite, and wrote 6 queries using SUM, LAG, CTEs, window functions and RANK. All queries are in pharma_analysis.sql.

## Findings
1. N02BE is the top category with 49.4% of total sales. N02BE and N05B together make up about 64%. N05C is the smallest at about 1%.
2. N02BE sales rise sharply every autumn. The biggest jumps were October 2014 (+109.1%), September 2019 (+90.0%), October 2015 (+84.8%) and September 2017 (+57.2%).
3. The spikes are followed by drops, for example November 2014 (-61.0%) and November 2016 (-34.3%). This suggests a seasonal cycle.
4. January 2017 shows zero or near-zero sales in every category, which looks like missing data, so it was excluded from the growth analysis.

## Recommendations
1. Plan stock and promotions for N02BE ahead of September and October.
2. Monitor N02BE closely, since it is half of all sales and any dip has a big impact.
3. Review whether N05C, at about 1% of sales, deserves the same level of sales effort.

## Limitations
The data has no regions or customer details, so the analysis is by category and time only. The seasonal pattern is a suggestion, not proven. October 2019 is the last month in the file and may be incomplete.

## Files
- pharma_analysis.sql: all 6 queries with comments
- salesmonthly.csv: the cleaned data
