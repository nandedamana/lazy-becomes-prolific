package calc

import(
	"fmt"
  "log"
  "net/http"

  "github.com/go-chi/chi/v5"
  "github.com/go-chi/chi/v5/middleware"

  oapimiddleware "github.com/deepmap/oapi-codegen/pkg/chi-middleware"
)

type Calc struct {
}

func NewCalcHandler() http.Handler {
	calc := Calc{}
	
	swagger, err := GetSwagger()
	if err != nil {
		log.Fatal("error loading OpenAPI spec.")
	}
	
	c := chi.NewRouter()
	
	c.Use(middleware.Logger)
	c.Use(oapimiddleware.OapiRequestValidator(swagger))
	
	return HandlerFromMux(calc, c)
}

func (calc Calc) GetCalcSum(w http.ResponseWriter, r *http.Request, params GetCalcSumParams) {
	fmt.Fprintf(w, "%d\n", params.X + params.Y)
}

func (calc Calc) GetCalcDiff(w http.ResponseWriter, r *http.Request, params GetCalcDiffParams) {
	fmt.Fprintf(w, "%d\n", params.X - params.Y)
}
