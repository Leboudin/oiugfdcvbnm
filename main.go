package main

import (
    "net/http"
    "log"
)

func handler(w http.ResponseWriter, r *http.Request) {
    msg := "Hello sir, service 2 is at your service"
    _, _ = w.Write([]byte(msg))
}

func main() {
    mux := http.NewServeMux()
    mux.HandleFunc("/", handler)
    log.Println("service starting")
    log.Fatalln(http.ListenAndServe(":80", mux))
}