import pymysql
from task_03_config import host, user, password, db_name

try:
    connection = pymysql.connect(
        host=host,  
        port=3306,
        user=user,  
        password=password,
        database=db_name,
        cursorclass=pymysql.cursors.DictCursor
    )
    print("Connected")

    try:
        cursor = connection.cursor()

       # drop
        drop_query = """DROP TABLE IF EXISTS sales;"""
        cursor.execute(drop_query)

        # create
        create_query = """ CREATE TABLE IF NOT EXISTS sales
                        (
                            id INT PRIMARY KEY AUTO_INCREMENT,
                            order_date DATE NOT NULL,
                            count_product INT NOT NULL
                        ); """
        
        cursor.execute(create_query)
      
        # insert
        cursor.execute("""
            INSERT INTO sales(order_date, count_product)
            VALUES
        	(DATE '2022-01-01', 156),
        	(DATE '2022-01-02', 180),
        	(DATE '2022-01-03', 21),
        	(DATE '2022-01-04', 124),
        	(DATE '2022-01-05', 341);
        """)
        connection.commit() 
        print("Table created successfully")

               
        # update
        update_query = """UPDATE sales SET count_product = 1000 WHERE id = 1;"""
        cursor.execute(update_query)
        connection.commit()  
        print("UPDATE successfully")

        # delete
        cursor.execute("DELETE FROM sales WHERE id = 3;")
        connection.commit() 
        print("DELETE successfully")

        # read = select
        select_query = "SELECT * FROM sales;"
        cursor.execute(select_query)
        rows = cursor.fetchall()
        for row in rows:
            print(row['id'])
            print(row['order_date'])
            print(row['count_product'])
            print(row)
        print(rows)

    finally:
        connection.close()


except Exception as ex:
    print(ex)
    print("Refused")
