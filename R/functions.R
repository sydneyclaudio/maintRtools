utils::globalVariables(c("category"))
#' Clean Work Orders
#'
#' This function cleans maintenance work order data by standardizing
#' column names and converting date columns.
#'
#' @param df A data frame containing work order data
#'
#' @return A cleaned data frame
#' @export
clean_work_orders <- function(df) {

  # Convert column names to lowercase
  names(df) <- tolower(names(df))

  # Convert date columns if they exist
  if ("created_date" %in% names(df)) {
    df$created_date <- as.Date(df$created_date)
  }

  if ("completed_date" %in% names(df)) {
    df$completed_date <- as.Date(df$completed_date)
  }

  return(df)
}
#' Calculate Delay Days
#'
#' This function calculates the number of days between created and completed dates.
#'
#' @param df A data frame containing work order data
#'
#' @return A data frame with a new column for delay days
#' @export
calculate_delay_days <- function(df) {

  if (!("created_date" %in% names(df)) || !("completed_date" %in% names(df))) {
    stop("Data must contain created_date and completed_date columns")
  }

  df$delay_days <- as.numeric(df$completed_date - df$created_date)

  return(df)
}
#' Summarize Work Orders by Category
#'
#' This function counts the number of work orders by category.
#'
#' @param df A data frame containing work order data
#'
#' @return A summary data frame with counts by category
#' @export
summarize_by_category <- function(df) {

  if (!("category" %in% names(df))) {
    stop("Data must contain a category column")
  }

  summary <- dplyr::summarise(
    dplyr::group_by(df, category),
    count = dplyr::n()
  )

  return(summary)
}
#' Flag Delayed Work Orders
#'
#' This function flags work orders that exceed a specified delay threshold.
#'
#' @param df A data frame containing work order data
#' @param threshold Number of days to consider as delayed (default = 3)
#'
#' @return A data frame with a new column indicating delayed orders
#' @export
flag_delayed_orders <- function(df, threshold = 3) {

  if (!("delay_days" %in% names(df))) {
    stop("Data must contain delay_days column. Run calculate_delay_days first.")
  }

  df$is_delayed <- df$delay_days > threshold

  return(df)
}
#' Plot Work Order Trends
#'
#' This function creates a bar chart of work orders by category.
#'
#' @param df A data frame containing work order data
#'
#' @return A ggplot object
#' @export
plot_work_order_trends <- function(df) {

  if (!("category" %in% names(df))) {
    stop("Data must contain a category column")
  }

  plot <- ggplot2::ggplot(df, ggplot2::aes(x = category)) +
    ggplot2::geom_bar(fill = "darkgreen") +
    ggplot2::labs(
      title = "Work Orders by Category",
      x = "Category",
      y = "Count"
    ) +
    ggplot2::theme_minimal()

  return(plot)
}
