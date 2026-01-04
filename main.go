package main

import (
	"context"
	"os"

	"github.com/tekintian/hookflow/v1/cmd"
	"github.com/tekintian/hookflow/v1/internal/log"
)

func main() {
	if err := cmd.Hookflow().Run(context.Background(), os.Args); err != nil {
		if err.Error() != "" {
			log.Errorf("Error: %s", err)
		}
		os.Exit(1)
	}
}
