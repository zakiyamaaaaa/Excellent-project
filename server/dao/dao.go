package dao

import (
	"database/sql"
	// mysql
	_ "github.com/go-sql-driver/mysql"
	"github.com/sirupsen/logrus"
)

const (
	driver   = "mysql"
	hostname = "mysql"
	port     = "3306"
	username = "root"
	password = "root"
	dbName   = "noside"
)

var db *sql.DB

func init() {

	d, err := sql.Open(driver, username+":"+password+"@tcp("+hostname+":"+port+")/"+dbName)
	if err != nil {
		logrus.Fatal(err.Error())
	}

	db = d
}
