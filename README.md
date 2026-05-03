
# maintRtools

<!-- badges: start -->
<!-- badges: end -->

`maintRtools` is an R package designed to help clean, analyze, and visualize maintenance work order data. The package focuses on common maintenance workflow questions such as how long work orders take, which categories appear most often, and which requests may be considered delayed.


## Functions

This package includes five main functions:

- `clean_work_orders()` cleans column names and converts date fields.
- `calculate_delay_days()` calculates the number of days between created and completed dates.
- `summarize_by_category()` counts work orders by maintenance category.
- `flag_delayed_orders()` flags work orders that exceed a chosen delay threshold.
- `plot_work_order_trends()` creates a bar chart of work orders by category.

## Example

```r
sample_orders <- data.frame(
  Work_Order_ID = c(1, 2, 3),
  Created_Date = c("2026-04-01", "2026-04-03", "2026-04-05"),
  Completed_Date = c("2026-04-03", "2026-04-07", "2026-04-06"),
  Category = c("HVAC", "Plumbing", "Electrical")
)

cleaned_data <- clean_work_orders(sample_orders)
delay_data <- calculate_delay_days(cleaned_data)
flag_delayed_orders(delay_data)
summarize_by_category(cleaned_data)
plot_work_order_trends(cleaned_data)

