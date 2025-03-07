TAXI_TYPE=$1
YEAR=$2
MONTH=$3

FMONTH=$(printf "%02d" ${MONTH})

URL_PREFIX="https://d37ci6vzurychx.cloudfront.net/trip-data"
URL=${URL_PREFIX}/${TAXI_TYPE}_tripdata_${YEAR}-${FMONTH}.parquet

OUTPUT_DIRECTORY="data/homework"/${TAXI_TYPE}_tripdata_${YEAR}-${FMONTH}
OUTPUT_FILE=${TAXI_TYPE}_tripdata_${YEAR}-${FMONTH}.parquet
OUTPUT_PATH=${OUTPUT_DIRECTORY}/${OUTPUT_FILE}

mkdir -p ${OUTPUT_DIRECTORY}

wget ${URL} -O ${OUTPUT_PATH}

# https://d37ci6vzurychx.cloudfront.net/trip-data/yellow_tripdata_2024-11.parquet
