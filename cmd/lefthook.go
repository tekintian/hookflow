package cmd

import (
	"github.com/urfave/cli/v3"

	ver "github.com/tekintian/hookflow/v1/internal/version"
)

func Hookflow() *cli.Command {
	return &cli.Command{
		Name:                  "hookflow",
		Usage:                 "Git hooks manager",
		Version:               ver.Version(true),
		Commands:              commands,
		EnableShellCompletion: true,
	}
}
