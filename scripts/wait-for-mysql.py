import argparse
import os
import sys
import time

import MySQLdb


def connect():

    parser = argparse.ArgumentParser(
        description="wait-for-mysql waits for a valid db-connection"
    )
    parser.add_argument("--db-host", default=os.environ.get("DB_HOST"))
    parser.add_argument("--db-name", default=os.environ.get("DB_NAME"))
    parser.add_argument("--db-user", default=os.environ.get("DB_USER"))
    parser.add_argument("--db-password", default=os.environ.get("DB_PASSWORD"))
    parser.add_argument(
        "--db-connect-timeout", default=os.environ.get("DB_CONNECT_TIMEOUT", 3)
    )
    parser.add_argument(
        "--db-create-if-not-exists",
        default=(
            os.environ.get("DB_CREATE_IF_NOT_EXISTS", True) in (True, "True", "true")
        ),
    )

    args = parser.parse_args()
    if None in [args.db_host, args.db_name, args.db_user, args.db_password]:
        exit(parser.print_usage())

    print("Pinging %s database host" % (args.db_host))
    db = None
    while True:
        try:
            db = MySQLdb.connect(
                host=args.db_host,
                user=args.db_user,
                passwd=args.db_password,
                connect_timeout=args.db_connect_timeout,
            )
            break
        except MySQLdb.DatabaseError:
            print("No reply in 2 secs. Pinging %s database host again" % (args.db_host))
            time.sleep(2)
            continue
    db.ping()

    if args.db_create_if_not_exists:
        db.query(
            "CREATE DATABASE IF NOT EXISTS `%s` CHARACTER SET utf8" % (args.db_name)
        )

    return 0


if __name__ == "__main__":
    sys.exit(connect())
