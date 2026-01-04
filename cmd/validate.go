package cmd

import (
	"context"

	"github.com/urfave/cli/v3"

	"github.com/tekintian/hookflow/v1/internal/command"
)

func validate() *cli.Command {
	var args command.ValidateArgs
	var verbose bool

	return &cli.Command{
		Name:  "validate",
		Usage: "validate hookflow config",
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
				return nil
			}

			return l.Validate(ctx, args)
		},
		ShellComplete: func(ctx context.Context, cmd *cli.Command) {
			command.ShellCompleteFlags(cmd)
		},
	}
}
