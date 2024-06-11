# pylint: disable=invalid-name
import json

from yoyo import step
import os

ENVS_DATA = json.loads(os.environ['APP_CREDENTIALS'])

USERNAME = ENVS_DATA['username']
PASSWORD = ENVS_DATA['password']
DATABASE = ENVS_DATA['dbname']


# Define the table names
PRODUCTS_TABLE = 'products'
SALES_TABLE = 'sales'

def apply_step(conn):
    cursor = conn.cursor()
    cursor.execute('''
        CREATE TABLE IF NOT EXISTS {} (
            id INT PRIMARY KEY,
            name VARCHAR(100),
            price INT
        );
    '''.format(PRODUCTS_TABLE))
    
    cursor.execute('''
        CREATE TABLE IF NOT EXISTS {} (
            id INT PRIMARY KEY,
            product_id INT,
            date DATE,
            quantity INT,
            price DECIMAL(10, 2),
            FOREIGN KEY (product_id) REFERENCES {}(id)
        );
    '''.format(SALES_TABLE, PRODUCTS_TABLE))
    
    conn.commit()

def rollback_step(conn):
    cursor = conn.cursor()
    cursor.execute('DROP TABLE IF EXISTS {};'.format(SALES_TABLE))
    cursor.execute('DROP TABLE IF EXISTS {};'.format(PRODUCTS_TABLE))
    conn.commit()

steps = [step(apply_step, rollback_step)]