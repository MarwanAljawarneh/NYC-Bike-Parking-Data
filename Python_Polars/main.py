import polars as pl
import psycopg2
from io import StringIO
# Load and clean the CSV with Polars
df = pl.read_csv("Bicycle_Parking_20250305.csv", dtypes={"BoroCD": pl.Utf8})
df = df.fill_null('')

# Convert polars dataframe to csv in memory
buffer =StringIO()
df.write_csv(buffer)
buffer.seek(0)
# Connect to PostgreSQL
conn = psycopg2.connect(
    host="localhost", 
    database="bike_parking_data",  
    user="marwan",  
    password="123",  
    port="5432"  
)
cursor = conn.cursor()

# Create table (if it doesn't exist)
create_table_query = """
CREATE TABLE IF NOT EXISTS bicycle_parking (
    the_geom TEXT, 
    BoroCode INT,
    BoroName VARCHAR(255),
    BoroCD INT,
    CounDist INT,
    AssemDist INT,
    StSenDist INT,
    CongDist INT,
    Program VARCHAR(255),
    Site_ID VARCHAR(255),
    Group_ID VARCHAR(255),
    Borough VARCHAR(255),
    IFOAddress VARCHAR(255),
    OnStreet VARCHAR(255),
    FromStreet VARCHAR(255),
    ToStreet VARCHAR(255),
    Side_of_St VARCHAR(1),
    RackType VARCHAR(255),
    Date_Inst DATE,  
    Latitude FLOAT,
    Longitude FLOAT,
    NTAName VARCHAR(255),
    FEMAFldz VARCHAR(255),
    FEMAFldT VARCHAR(255),
    HrcEvac VARCHAR(255)
);
"""
cursor.execute(create_table_query)
conn.commit()

# Prepare data to insert into PostgreSQL
# Convert DataFrame to list of tuples, where each row is a tuple
cursor.copy_expert("COPY bicycle_parking FROM STDIN WITH CSV HEADER DELIMITER ',' ",
buffer)

conn.commit()
cursor.close()
conn.close()




print("Data copied successfully!")


