To run the app

1 - bundle i
2 - rails db:create db:migrate 
3 - rails db:seeds  - this one optional (creates dummy data)

To run the import task on the provided CSVs

1 - rails import:movies    ( for reviews csv )
2 - rails import:reviews   ( for reviews csv )

Some extra stuff was implemented but is not required, to avoid making the test complicated.


a File named test.http is in the root directory of the app and contains the apis a long with request body example.

NOTE: Reviews file may need to be modified by making user names match existing user names in the system
