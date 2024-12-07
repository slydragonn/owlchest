package main

import (
	"os"

	"github.com/gin-gonic/gin"
)

func main() {
	r := gin.Default()

	r.Static("/", "./public")

	port := os.Getenv("BACKEND_PORT")

	if port == "" {
		port = "8080"
	}

	r.Run(":" + port)
}
