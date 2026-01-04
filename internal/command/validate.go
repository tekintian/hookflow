package command

import (
	"context"
	"errors"

	"github.com/xeipuuv/gojsonschema"

	"github.com/tekintian/hookflow/v1/internal/config"
	"github.com/tekintian/hookflow/v1/internal/log"
)

type ValidateArgs struct {
	SchemaPath string
}

func (l *Hookflow) Validate(_ctx context.Context, args ValidateArgs) error {
	main, secondary, err := config.LoadKoanf(l.fs, l.repo)
	if err != nil {
		return err
	}

	schemaLoader := gojsonschema.NewBytesLoader(config.JsonSchema)
	mainLoader := gojsonschema.NewGoLoader(main.Raw())

	result, err := gojsonschema.Validate(schemaLoader, mainLoader)
	if err != nil {
		return err
	}

	if !result.Valid() {
		logValidationErrors(result.Errors())
		return errors.New("validation failed for main config")
	}

	secondaryLoader := gojsonschema.NewGoLoader(secondary.Raw())
	result, err = gojsonschema.Validate(schemaLoader, secondaryLoader)
	if err != nil {
		return err
	}

	if !result.Valid() {
		logValidationErrors(result.Errors())
		return errors.New("validation failed for secondary config")
	}

	log.Info("All good")
	return nil
}

func logValidationErrors(errors []gojsonschema.ResultError) {
	for _, err := range errors {
		log.Info(log.Yellow(err.Field()), log.Red(err.Description()))
	}
}
