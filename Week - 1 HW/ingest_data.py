#!/usr/bin/env python
# coding: utf-8

import pandas as pd
import os
import gzip
import shutil
from sqlalchemy import create_engine
import argparse


def main(params):
    user=params.user
    password=params.password
    host=params.host
    port=params.port
    db=params.db
    table_name_1=params.table_name_1
    table_name_2=params.table_name_2
    url1=params.url1
    url2=params.url2
    


    # Now we have the csv files

    zipped_trip_data_file = "green_tripdata_2019-10.csv.gz"
    zone_data_file = "taxi_zone_lookup.csv"


    os.system(f"wget {url1} -O {zipped_trip_data_file}")
    os.system(f"wget {url2} -O {zone_data_file}")


    # checking if the files are downloaded
    if os.path.exists(zipped_trip_data_file):
        print(f"{zipped_trip_data_file} downloaded successfully")
    else:
        raise FileNotFoundError(f"Failed to download {zipped_trip_data_file}")

    if os.path.exists(zone_data_file):
        print(f"{zone_data_file} downloaded successfully")
    else:
        raise FileNotFoundError(f"Failed to download {zone_data_file}")


    # unzipping the file
    unzipped_trip_data_file = "green_tripdata_2019-10.csv"
    with gzip.open(zipped_trip_data_file, 'rb') as f_in:
        with open(unzipped_trip_data_file, 'wb') as f_out:
            shutil.copyfileobj(f_in, f_out)


    # reading the data into dataframes
    df_trip = pd.read_csv(unzipped_trip_data_file)
    df_zone = pd.read_csv(zone_data_file)


    # establishing the connection with the db we created using docker
    conn = create_engine(f'postgresql://{user}:{password}@{host}:{port}/{db}')
    print('connection successful')


    df_trip.head(n=0).to_sql(name='green_taxi_trips', con=conn, if_exists='replace')
    print('Table_trips created successfully')
    print('Appending data...')
    df_trip.to_sql(name='green_taxi_trips', con=conn, if_exists='append')
    print('Data appending succesful')

    df_zone.head(n=0).to_sql(name='green_taxi_zones', con=conn, if_exists='replace')
    print('Table_zones created successfully')
    print('Appending data...')
    df_zone.to_sql(name='green_taxi_zones', con=conn, if_exists='append')
    print('Data appending succesful')


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Ingest csv data to Postgres')

    # user, passwprd, host, port, database name, table name, url of parquet
    parser.add_argument('--user', help='username for postgres - root')
    parser.add_argument('--password', help='password for postgres - root')
    parser.add_argument('--host', help='host for postgres - localhost')
    parser.add_argument('--port', help='post number for postgres - 5432')
    parser.add_argument('--db', help='name of database for postgres - ny_taxi')
    parser.add_argument('--table_name_1', help='name of the table where we will write the results to - green_taxi_trips')
    parser.add_argument('--table_name_2', help='name of the table where we will write the results to - green_taxi_zones')
    parser.add_argument('--url1', help='url of the trips file')
    parser.add_argument('--url2', help='url of the zones file')

    args = parser.parse_args()

    main(args)