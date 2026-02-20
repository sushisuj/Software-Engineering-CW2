import sqlite3

con = sqlite3.connect("tutorial.db")

con.execute("CREATE TABLE user(user_id SERIAL PRIMARY KEY, email VARCHAR(50), password_hash, created_at DATETIME)")
