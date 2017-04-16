package dao

// User :
type User struct {
	UID   string `json:"uid"`
	Name  string `json:"name"`
	Email string `json:"email"`
	//	Lat   string
	//	Lon   string
}

const userTable = "user"

// Load user
func (u *User) Load(uid string) (user *User, err error) {
	rows, err := db.Query(`select name, email from ? where uid = "?"`, userTable, uid)
	if err != nil {
		return nil, err
	}

	var name, email string
	err = rows.Scan(&uid, &name, &email)
	if err != nil {
		return nil, err
	}

	return &User{UID: uid, Name: name, Email: email}, nil
}

// Save user
func (u *User) Save() (err error) {
	//_, err = db.Exec(`insert into `+userTable+` (uid, name, email, latlon) values (?, ?, ?, GeomFromText('POINT(`+u.Lat+` `+u.Lon+`)'))`, u.UID, u.Name, u.Email)

	_, err = db.Exec(`insert into `+userTable+` (uid, name, email) values (?, ?, ?)`, u.UID, u.Name, u.Email)
	if err != nil {
		return err
	}

	return nil
}

// UpdateGeometry :
func (u *User) UpdateGeometry() (err error) {
	//_, err = db.Exec(`update `+userTable+` set latlon = GeomFromText('POINT(`+u.Lat+` `+u.Lon+`)') where uid = "?"`, u.UID)
	//if err != nil {
	//	return err
	//}
	return nil
}

// SearchUser :
func (u *User) SearchUser() (users []User, err error) {
	rows, err := db.Query(`select uid, name, email from ` + userTable + ` order by rand() limit 10`)

	for rows.Next() {
		var uid, name, email string
		if err := rows.Scan(&uid, &name, &email); err != nil {
			return nil, err
		}
		u := User{UID: uid, Name: name, Email: email}
		users = append(users, u)
	}

	return users, nil
}
