# scripts/db_utils.py
import os
from sqlalchemy import create_engine
from dotenv import load_dotenv
from sqlalchemy import text

def get_db_engine(env_path=''):
    if env_path == '':
        env_path = os.path.join(os.path.dirname(os.path.dirname(__file__)), '.env')
        print(f"🔍 Loading .env from: {env_path}")

    if not os.path.exists(env_path):
        raise FileNotFoundError(f"❌ .env file not found at {env_path}")

    load_dotenv(env_path)

    user = os.getenv('MYSQL_USER')
    password = os.getenv('MYSQL_PASSWORD')
    host = os.getenv('MYSQL_HOST')
    port = os.getenv('MYSQL_PORT')
    database = os.getenv('MYSQL_DATABASE')

    print(f"🔧 Variables loaded: user={user}, host={host}, db={database}")

    if not all([user, password, host, port, database]):
        raise ValueError("❌ ENV variables not present: check .env")

    connection_string = f"mysql+pymysql://{user}:{password}@{host}:{port}/{database}"

    engine = create_engine(connection_string)
    return engine

def open_connection(engine):
    return engine.connect()

def close_connection(conn):
    if conn and not conn.closed:
        conn.close()
        print("✅ DB connection closed")


def get_table_count(conn, table_name: str) -> int:
    """
    Restituisce il numero di righe presenti in una tabella del DB.
    
    :param conn: connessione aperta al DB
    :param table_name: nome della tabella
    :return: numero di righe
    """
    query = text(f"SELECT COUNT(*) AS total FROM {table_name};")
    result = conn.execute(query)
    return result.scalar()