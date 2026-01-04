package cmd

import (
	"context"

	"github.com/urfave/cli/v3"

	"github.com/tekintian/hookflow/v1/internal/command"
)

func install() *cli.Command {
	var args command.InstallArgs
	var verbose bool

	return &cli.Command{
		Name:      "install",
		Usage:     "install Git hook from the config or create a blank hookflow.yml",
		UsageText: "hookflow install [hook-names...] [options]",
		Flags: []cli.Flag{
			&cli.BoolFlag{
				Name:        "force",
				Usage:       "overwrite .old files",
				Aliases:     []string{"f"},
				Destination: &args.Force,
			},
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

			return l.Install(ctx, args, cmd.Args().Slice())
		},
		ShellComplete: func(ctx context.Context, cmd *cli.Command) {
			command.ShellCompleteFlags(cmd)
			command.ShellCompleteHookNames()
		},
	}
}
