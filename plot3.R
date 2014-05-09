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
png(filename="plot3.png")

# Plot the frame
plot(data$Time, data$Sub_metering_1, type="n",
     ylab="Energy sub metering",
     xlab="")

# Draw the lines
lines(data$Time, data$Sub_metering_1, col="black")
lines(data$Time, data$Sub_metering_2, col="red")
lines(data$Time, data$Sub_metering_3, col="blue")

# Draw the legend
legend("topright",
       legend=c("Sub_metering_1",
                "Sub_metering_2",
                "Sub_metering_3"),
       col=c("black", "red", "blue"),
       lty=1)

# Close the device
dev.off()
