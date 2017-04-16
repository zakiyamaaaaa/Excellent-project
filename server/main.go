package main

import (
	"encoding/json"
	"excellent-project/server/dao"
	"github.com/gorilla/mux"
	"github.com/sirupsen/logrus"
	"net/http"
)

func main() {
	router := mux.NewRouter()
	router.HandleFunc("/register", register).Methods("POST")
	router.HandleFunc("/auth", auth).Methods("GET")
	router.HandleFunc("/geometry/register", registerGeometry).Methods("POST")
	router.HandleFunc("/search", search).Methods("GET")
	http.Handle("/", router)

	err := http.ListenAndServe(":5000", nil)
	if err != nil {
		logrus.Fatal(err.Error())
	}
}

func register(w http.ResponseWriter, r *http.Request) {
	uid := r.FormValue("uid")
	name := r.FormValue("name")
	email := r.FormValue("email")

	user := dao.User{UID: uid, Name: name, Email: email}
	logrus.Info(user)
	err := user.Save()
	if err != nil {
		w.WriteHeader(http.StatusBadRequest)
		logrus.Error(err.Error())
		return
	}

	w.WriteHeader(http.StatusOK)
}
func auth(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("ke", "value")
	w.WriteHeader(http.StatusOK)
	w.Write([]byte("test"))

}

func registerGeometry(w http.ResponseWriter, r *http.Request) {
	/*vars := mux.Vars(r)
	uid := vars["uid"]
	lat := vars["lat"]
	lon := vars["lon"]

	user, err := (&dao.User{}).Load(uid)
	if err != nil {
		w.WriteHeader(http.StatusBadRequest)
		logrus.Error(err.Error())
		return
	}

	user.Lat = lat
	user.Lon = lon
	err = user.Save()
	if err != nil {
		w.WriteHeader(http.StatusBadRequest)
		logrus.Error(err.Error())
		return
	}

	w.WriteHeader(http.StatusOK)
	*/
}

type searchResponse struct {
	Count int        `json:"count"`
	Users []dao.User `json:"users"`
}

func search(w http.ResponseWriter, r *http.Request) {

	users, err := (&dao.User{}).SearchUser()
	if err != nil {
		w.WriteHeader(http.StatusBadRequest)
		logrus.Error(err.Error())
		return
	}

	res := searchResponse{Count: len(users), Users: users}
	json, err := json.Marshal(res)
	if err != nil {
		w.WriteHeader(http.StatusInternalServerError)
		logrus.Error(err.Error())
		return
	}

	w.WriteHeader(http.StatusOK)
	w.Write(json)
}
