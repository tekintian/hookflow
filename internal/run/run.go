package run

import (
	"context"

	"github.com/tekintian/hookflow/v1/internal/config"
	"github.com/tekintian/hookflow/v1/internal/git"
	"github.com/tekintian/hookflow/v1/internal/run/controller"
	"github.com/tekintian/hookflow/v1/internal/run/result"
)

var ErrFailOnChanges = controller.ErrFailOnChanges

type Options = controller.Options

func Run(ctx context.Context, hook *config.Hook, repo *git.Repository, opts Options) ([]result.Result, error) {
	return controller.NewController(repo).RunHook(ctx, opts, hook)
}
