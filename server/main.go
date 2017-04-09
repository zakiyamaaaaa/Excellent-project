package main

import (
	"database/sql"
	_ "github.com/go-sql-driver/mysql"
	"log"
)

func getDB(dbName, username, password string) (*sql.DB, error) {

	db, err := sql.Open("mysql",
		username+":"+password+"@/"+dbName)
	if err != nil {
		return nil, err
	}

	return db, nil
}

func main() {
	db, err := getDB("test", "root", "root")
	if err != nil {
		log.Fatal(err.Error())
	}

	// レコード挿入
	_, err = db.Exec(`insert into test values (?, ?)`, "ichihara", "shinji")
	if err != nil {
		log.Fatal(err.Error())
	}

	rows, err := db.Query("select last_name, first_name from test")
	if err != nil {
		log.Fatal(err.Error())
	}

	var last_name string
	var first_name string

	for rows.Next() {
		rows.Scan(&last_name, &first_name)
		log.Print(last_name + ":" + first_name)
	}

}
