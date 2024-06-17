# pylint: disable=invalid-name
import json

from yoyo import step
import os

ENVS_DATA = json.loads(os.environ['APP_CREDENTIALS'])

USERNAME = ENVS_DATA['username']
PASSWORD = ENVS_DATA['password']
DATABASE = ENVS_DATA['dbname']


def apply_step(conn):
    cursor = conn.cursor()
    cursor.execute('CREATE USER IF NOT EXISTS \'{}\'@\'%\' IDENTIFIED BY \'{}\';'.format(
        USERNAME, PASSWORD))
    cursor.execute(
        'GRANT ALL PRIVILEGES ON {}.* TO \'{}\'@\'%\';'.format(
            DATABASE, USERNAME))
    cursor.execute('FLUSH PRIVILEGES;')

def rollback_step(conn):
    cursor = conn.cursor()
    cursor.execute(
        'REVOKE ALL PRIVILEGES ON {}.* FROM \'{}\'@\'%\';'.format(DATABASE, USERNAME))
    cursor.execute('DROP USER IF EXISTS \'{}\'@\'%\';'.format(USERNAME))
    cursor.execute('FLUSH PRIVILEGES;')

steps = [step(apply_step, rollback_step)]
