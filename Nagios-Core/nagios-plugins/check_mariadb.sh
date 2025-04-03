#!/bin/bash

#  check_mariadb verifies a MariaDB database by checking:
#  - DB response validation
#  - DB response time
#  - Number of active processes
#  - DB size in MB

#  Recommended for optimization:
#  - Ensure MySQL is installed
#  - Ensure the Nagios user has permissions
#  - If the DB is very large, keep the indexes optimized
#  - You can avoid exposing the password by storing the credentials in the ~/.my.cnf file

# Defining default values
USER="nagios"
PASSWORD=""
HOST="localhost"
DATABASE="test"
WARNING_TIME=1
CRITICAL_TIME=2
WARNING_PROC=100
CRITICAL_PROC=200
WARNING_SIZE=500
CRITICAL_SIZE=1000

# Function to show usage
usage() {
    echo "Uso: $0 -u <user_name> -p <user_password> -h <host> -d <db_name> -w <seconds> -c <seconds> -W <proc_warn> -C <proc_crit> -S <size_warn> -Z <size_crit>"
    exit 3
}

# Options processing
while getopts "u:p:h:d:w:c:W:C:S:Z:" opt; do
    case "$opt" in
        u) USER="$OPTARG" ;;
        p) PASSWORD="$OPTARG" ;;
        h) HOST="$OPTARG" ;;
        d) DATABASE="$OPTARG" ;;
        w) WARNING_TIME="$OPTARG" ;;
        c) CRITICAL_TIME="$OPTARG" ;;
        W) WARNING_PROC="$OPTARG" ;;
        C) CRITICAL_PROC="$OPTARG" ;;
        S) WARNING_SIZE="$OPTARG" ;;
        Z) CRITICAL_SIZE="$OPTARG" ;;
        *) usage ;;
    esac
done

# Validation of mandatory parameters
if [[ -z "$USER" || -z "$PASSWORD" || -z "$HOST" || -z "$DATABASE" ]]; then
    usage
fi

# Measure response time
START_TIME=$(date +%s.%N)
QUERY_TIME=$(mysql -u "$USER" -p"$PASSWORD" -h "$HOST" -D "$DATABASE" -e "SELECT 1;" 2>&1)
EXIT_CODE=$?
END_TIME=$(date +%s.%N)
RESPONSE_TIME=$(echo "$END_TIME - $START_TIME" | bc)

# Check for connection error
if [[ $EXIT_CODE -ne 0 ]]; then
    echo "CRITICAL - Error connecting to MariaDB: $QUERY_TIME"
    exit 2
fi

# Get the number of active processes
PROCESS_COUNT=$(mysql -u "$USER" -p"$PASSWORD" -h "$HOST" -D "$DATABASE" -e "SHOW PROCESSLIST;" | wc -l)
PROCESS_COUNT=$((PROCESS_COUNT - 1))  # Subtract the header row

# Get database size in MB
DATABASE_SIZE=$(mysql -u "$USER" -p"$PASSWORD" -h "$HOST" -D "$DATABASE" -e "SELECT ROUND(SUM(data_length + index_length) / 1024 / 1024, 2) FROM information_schema.tables WHERE table_schema = '$DATABASE';" -s -N)
DATABASE_SIZE=${DATABASE_SIZE:-0}  # If the query fails, set 0

# Evaluate thresholds
STATUS=0
MESSAGE="OK - Time: ${RESPONSE_TIME}s, Process: ${PROCESS_COUNT}, Size: ${DATABASE_SIZE}MB"

if (( $(echo "$RESPONSE_TIME >= $CRITICAL_TIME" | bc -l) )); then
    STATUS=2
    MESSAGE="CRITICAL - Time: ${RESPONSE_TIME}s | time=${RESPONSE_TIME}s"
elif (( $(echo "$RESPONSE_TIME >= $WARNING_TIME" | bc -l) )); then
    STATUS=1
    MESSAGE="WARNING - Time: ${RESPONSE_TIME}s | time=${RESPONSE_TIME}s"
fi

if (( PROCESS_COUNT >= CRITICAL_PROC )); then
    STATUS=2
    MESSAGE="CRITICAL - Process: ${PROCESS_COUNT} | processes=${PROCESS_COUNT}"
elif (( PROCESS_COUNT >= WARNING_PROC )); then
    STATUS=1
    MESSAGE="WARNING - Process: ${PROCESS_COUNT} | processes=${PROCESS_COUNT}"
fi

if (( $(echo "$DATABASE_SIZE >= $CRITICAL_SIZE" | bc -l) )); then
    STATUS=2
    MESSAGE="CRITICAL - DB size: ${DATABASE_SIZE}MB | db_size=${DATABASE_SIZE}MB"
elif (( $(echo "$DATABASE_SIZE >= $WARNING_SIZE" | bc -l) )); then
    STATUS=1
    MESSAGE="WARNING - DB size: ${DATABASE_SIZE}MB | db_size=${DATABASE_SIZE}MB"
fi

echo "$MESSAGE | time=${RESPONSE_TIME}s;${WARNING_TIME};${CRITICAL_TIME} processes=${PROCESS_COUNT};${WARNING_PROC};${CRITICAL_PROC} db_size=${DATABASE_SIZE}MB;${WARNING_SIZE};${CRITICAL_SIZE}"
exit $STATUS
