package datos

//go:generate mockgen -source=datos.go  -destination=../../mocks/mock_datos.go -package=mock_datos example.com/cosa Api

func Fregar() bool { // Mockear
	return true
}

type Api interface{ Fregar() bool }

// CASA
type Casa struct {
	Tamano int
	Api    Api
}

type Reforma interface {
	LimpiaCasa() int
}

func (c *Casa) LimpiaCasa() bool {
	return c.Api.Fregar()
}
func NewCasa(api Api) *Casa {
	return &Casa{
		Tamano: 123,
		Api:    api,
	}
}
