package cmd

import (
	"context"

	"github.com/urfave/cli/v3"

	"github.com/tekintian/hookflow/v1/internal/command"
)

func checkInstall() *cli.Command {
	var verbose bool
	return &cli.Command{
		Name:  "check-install",
		Usage: "check if hooks are installed",
		UsageText: `hookflow check-install – Check if hookflow is installed. Exit codes:
0 – hooks are installed
1 – hooks are not installed or stale`,
		Flags: []cli.Flag{
			&cli.BoolFlag{
				Name:        "verbose",
				Aliases:     []string{"v"},
				Destination: &verbose,
			},
		},
		Action: func(ctx context.Context, cmd *cli.Command) error {
			l, err := command.NewHookflow(verbose, "auto")
			if err != nil {
				return err
			}

			return l.CheckInstall(ctx)
		},
		ShellComplete: func(ctx context.Context, cmd *cli.Command) {
			command.ShellCompleteFlags(cmd)
		},
	}
}
