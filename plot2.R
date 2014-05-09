library(sqldf)

# Read data, by transferring it to a temporary sqlite DB
# , and then selecting only the relevant rows from it.
# In this case only rows with date "1/2/2007", or "2/2/2007"
data <- data <- read.csv.sql(
    "household_power_consumption.txt",
    sql="select * from file where Date in ('1/2/2007', '2/2/2007')",
    sep=";")

# Convert Date column to R class Date
data$Date <- as.Date(data$Date,
                     format="%d/%m/%Y")
# Combine Date and Time columns into a POSIXlt Time
data$Time <- strptime(paste(data$Date, data$Time),
                      format="%Y-%m-%d %H:%M:%S")

# Open the PNG graphics device.
# Defaults for width and height are 480px
png(filename="plot2.png")

# Setup transparent background
par(bg=NA)

# Plot the graphic
plot(data$Time, data$Global_active_power,
     ylab="Global Active Power (kilowatts)",
     xlab="",
     type="l")

# Close the device
dev.off()
