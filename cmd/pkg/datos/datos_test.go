package datos

import (
	"testing"

	mock_datos "example.com/cosa/cmd/mocks"
	"github.com/golang/mock/gomock"
	"github.com/stretchr/testify/assert"
)

func TestCasa(t *testing.T) {
	ctrl := gomock.NewController(t)
	moc := mock_datos.NewMockApi(ctrl)
	moc.EXPECT().Fregar().Return(false)
	casa := NewCasa(moc)
	res := casa.LimpiaCasa()
	assert.True(t, res)
}
