package main

import(
	"log"
  "net/http"
  
  "oapi-codegen-demo/calc"
)

func main() {
  handler := calc.NewCalcHandler()

  log.Print("listening...")
  
  err := http.ListenAndServe(":8080", handler)
  if err != nil {
  	log.Fatalf("http.ListenAndServe() failed: %s", err)
  }
}
